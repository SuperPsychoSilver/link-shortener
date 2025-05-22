# Use official PHP image with Apache
FROM php:8.2-apache

# Install required PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable Apache modules
RUN a2enmod rewrite

# Update Apache to listen on port 8080
RUN sed -i 's/80/8080/g' /etc/apache2/ports.conf /etc/apache2/sites-enabled/000-default.conf

# Set ServerName to suppress warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Set default DirectoryIndex to index.php
RUN echo "DirectoryIndex index.php" >> /etc/apache2/apache2.conf

# Redirect root "/" to "/admin/"
RUN echo "RedirectMatch ^/$ /admin/" > /etc/apache2/conf-available/redirect.conf \
    && a2enconf redirect

# Copy app files
COPY . /var/www/html/

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html/ \
    && chmod -R 755 /var/www/html/

# Expose the desired port
EXPOSE 8080
