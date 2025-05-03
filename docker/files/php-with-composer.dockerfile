# docker/development/workspace/Dockerfile
# Use the official PHP CLI image as the base
FROM php:8.2-cli

# Install system dependencies and build libraries, including git
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    unzip \
    libpq-dev \
    libonig-dev \
    libssl-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libicu-dev \
    libzip-dev \
    libpcre3-dev \
    postgresql-client \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    git \
    && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    opcache \
    intl \
    zip \
    bcmath \
    soap \
    pcntl \
    gd

RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN pecl install redis && docker-php-ext-enable redis

# Set up composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer