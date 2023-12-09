#!/usr/bin/env bash

# Custom aliases
alias cls=clear
alias CLS=clear
alias trash='gio trash'

# Serve
function serve() {
    if [ -z "$1" ]
    then
        php -S localhost:8080
    else
        php -S localhost:8080 -t "$1"
    fi
}


# PHP aliases
alias phpunit='./vendor/bin/phpunit'
alias pu='./vendor/bin/phpunit'
alias pf='./vendor/bin/phpunit --filter'
alias pc='./vendor/bin/phpunit --coverage-html ./.phpunit.cache/report/html'

# Laravel artisan
function a() {
    if [ "$1" = "fresh" ]; then
        php artisan migrate:fresh
    elif [ "$1" = "seed" ]; then
        php artisan migrate:fresh --seed
    else
        php artisan $1 $2 $3 $4 $5
    fi
}

alias at='php artisan test'
alias af='php artisan test --filter'

# Laravel envoy and sail
alias envoy='./vendor/bin/envoy'
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

# Git commands
# Add git command directory to PATH variable
export PATH=$PATH:$HOME/.myshell/git
