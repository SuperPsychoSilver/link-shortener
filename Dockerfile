FROM php:8.2-apache

# Install mysqli for database support
RUN docker-php-ext-install mysqli

# Change Apache to listen on port 8080 (Railway expects this)
RUN sed -i 's/80/8080/g' /etc/apache2/ports.conf /etc/apache2/sites-enabled/000-default.conf

# Expose port 8080 to Railway
EXPOSE 8080

# Copy your app files into the container
COPY . /var/www/html/
