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

# Commands
# Add git command directory to PATH variable
# Add docker command directory to PATH variable
# Add composer bin directory to PATH varible
export PATH=$PATH:$HOME/.myshell/git:$HOME/.myshell/docker:$HOME/.composer/vendor/bin

# Proxy setup
function setproxy() {
    if ss -ltn | grep -q '127.0.0.1:8118'; then
        export HTTP_PROXY="http://127.0.0.1:8118"
        export HTTPS_PROXY="http://127.0.0.1:8118"
        echo "Proxy set to http://127.0.0.1:8118"
    else
        echo "Privoxy is not running on 127.0.0.1:8118"
    fi
}

function unsetproxy() {
    unset HTTP_PROXY
    unset HTTPS_PROXY
}
