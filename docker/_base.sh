#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


TTY_ARGS=""
if [ -t 0 ] && [ -t 1 ]; then
  TTY_ARGS="-it"
fi

docker run --init $TTY_ARGS \
  -v "$(pwd)":$(pwd) \
  -v "$HOME/.composer":$HOME/.composer \
  -v "$HOME/.config/psysh":$HOME/.config/psysh \
  -v "$HOME/.git-credentials":$HOME/.git-credentials \
  -v "$HOME/.gitconfig":$HOME/.gitconfig \
  -v /etc/ssl/certs:/etc/ssl/certs:ro \
  -v /usr/local/share/ca-certificates:/usr/local/share/ca-certificates:ro \
  -v "${SCRIPT_DIR}/custom-php.ini:/usr/local/etc/php/conf.d/custom-php.ini" \
  -e COMPOSER_HOME=$HOME/.composer \
  -e http_proxy="${http_proxy}" \
  -e https_proxy="${https_proxy}" \
  -e HTTP_PROXY="${HTTP_PROXY}" \
  -e HTTPS_PROXY="${HTTPS_PROXY}" \
  -e no_proxy="${no_proxy}" \
  -e HOME="${HOME}" \
  -w "$(pwd)" \
  --net=host \
  -u "$(id -u):$(id -g)" \
  php-with-composer $@
