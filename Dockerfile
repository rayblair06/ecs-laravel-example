# Base Image
FROM php:8.1-apache

# Configure apache
RUN a2enmod rewrite
COPY ./docker/000-default.conf /etc/apache2/sites-enabled/000-default.conf

# Copy files with dependencies
COPY . /var/www/html

# Grant permission to Apache user
WORKDIR /var/www/html

RUN chmod -R 770 storage
RUN chown -R www-data:www-data storage
