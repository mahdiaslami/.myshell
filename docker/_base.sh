#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker run -it \
  -v "$(pwd)":$(pwd) \
  -v "$HOME/.composer":$HOME/.composer \
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