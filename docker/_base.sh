#!/usr/bin/env bash

docker run -it \
  -v "$(pwd)":$(pwd) \
  -v "$HOME/.composer":$HOME/.composer \
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