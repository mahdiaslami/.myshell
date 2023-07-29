PROMPT="%{$fg[cyan]%}%c%{$reset_color%} "

function git_status() {
    local git_dir="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
    
    if [ "$git_dir" != "true" ]; then
        return
    fi

    local result="%{$fg_bold[blue]%}git::("

    local stash_count=$(git stash list | wc -l | awk '{print $1}')
    if [ "$stash_count" -gt 0 ]; then
        result+="🍮 "
    fi

    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    result+="%{$fg_bold[green]%}$branch%{$fg_bold[white]%}"

    local remote_branch_exists=$(git ls-remote --exit-code . "origin/$branch" >/dev/null 2>&1; echo $?)
    if [ "$remote_branch_exists" -ne 0 ]; then
        result+=" 👍"
    fi

    local ahead=0
    local behind=0
    if [ "$remote_branch_exists" -eq 0 ]; then
        ahead=$(git rev-list --count --left-right @{upstream}...HEAD | cut -f2)
        behind=$(git rev-list --count --left-right @{upstream}...HEAD | cut -f1)
    fi

    if [ "$ahead" -gt 0 ]; then
        result+=" $ahead 🚀"
    fi

    if [ "$behind" -gt 0 ]; then
        result+=" $behind 👇"
    fi

    local dirty=$(git diff --shortstat 2>/dev/null)
    if [ -n "$dirty" ]; then
        result+=" 🍳"
    fi

    result+="%{$fg_bold[blue]%})"
    result+="%{$reset_color%}"

    echo "$result"
}


PROMPT+='$(git_status) '
PROMPT+="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}"

unset LESS