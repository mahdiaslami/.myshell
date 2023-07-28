PROMPT="%{$fg[cyan]%}%c%{$reset_color%} "

function git_status() {
    local git_dir="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
    
    if [ "$git_dir" != "true" ]; then
        return
    fi

    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    local behind=$(git rev-list --count --left-right @{upstream}...HEAD | cut -f1)
    local ahead=$(git rev-list --count --left-right @{upstream}...HEAD | cut -f2)
    local dirty=$(git diff --shortstat 2>/dev/null)

    local result="%{$fg_bold[blue]%}git::(%{$fg_bold[green]%}$branch%{$fg_bold[white]%}"
    [ "$ahead" -gt 0 ] && result+=" $ahead ⬆️ "
    [ "$behind" -gt 0 ] && result+=" $behind ⬇️ "
    [ -n "$dirty" ] && result+=" ✏️ "
    result+="%{$fg_bold[blue]%})"
    result+="%{$reset_color%}"

    echo "$result"
}

PROMPT+='$(git_status) '
PROMPT+="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}"
