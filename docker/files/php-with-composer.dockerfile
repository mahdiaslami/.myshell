# Base image with PHP CLI
FROM php:8.2-cli

# Install required extensions
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo_pgsql

# Set up composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
