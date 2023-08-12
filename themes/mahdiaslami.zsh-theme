PROMPT="%{$fg[cyan]%}%c%{$reset_color%} "

function git_branch_status() {
    local value=$(git branch --list "${ref/refs\/heads\//}" --format "%(upstream:track)")
    if [[ $value == "[gone]" ]]; then
        echo " 👍"
    elif [[ $value == *"ahead"* && $value == *"behind"* ]]; then
        ahead=$(echo "$value" | grep -o 'ahead [0-9]*' | awk '{print $2}')
        behind=$(echo "$value" | grep -o 'behind [0-9]*' | awk '{print $2}')
        echo " $ahead🚀 $behind👇"
    elif [[ $value == *"ahead"* ]]; then
        ahead=$(echo "$value" | grep -o 'ahead [0-9]*' | awk '{print $2}')
        echo " $ahead🚀"
    elif [[ $value == *"behind"* ]]; then
        behind=$(echo "$value" | grep -o 'behind [0-9]*' | awk '{print $2}')
        echo " $behind👇"
    else
        echo ""
    fi
}

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

    local ref
    ref=$(git symbolic-ref --short HEAD 2> /dev/null) \
        || ref=$(git describe --tags --exact-match HEAD 2> /dev/null) \
        || ref=$(git rev-parse --short HEAD 2> /dev/null) \
        || return 0

    result+="%{$fg_bold[green]%}$ref%{$fg_bold[white]%}"

    result+="$(git_branch_status $ref)"

    local dirty=$(git status -s 2>/dev/null)
    if [ -n "$dirty" ]; then
        result+=" 🍺"
    fi

    result+="%{$fg_bold[blue]%})"
    result+="%{$reset_color%}"

    echo "$result"
}


PROMPT+='$(git_status) '
PROMPT+="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}"

unset LESS