# Base Builder image
FROM composer:latest as builder

WORKDIR /app

COPY ./ /app

# Install composer dependencies
RUN composer install --ignore-platform-reqs --no-progress --no-ansi --no-dev

# Test Steps, please remove these before actual use
RUN cp .env.example .env
RUN php artisan key:generate

# Base Server Image
FROM php:8.1-apache

# Configure apache
RUN a2enmod rewrite
COPY ./docker/000-default.conf /etc/apache2/sites-enabled/000-default.conf

# Copy files with dependencies
COPY --from=builder ./app /var/www/html

# Grant permission to Apache user
WORKDIR /var/www/html

RUN chmod -R 770 storage
RUN chown -R www-data:www-data storage
