FROM php:8.2-apache

RUN docker-php-ext-install mysqli

# Make Apache listen on port 8080
RUN sed -i 's/80/8080/g' /etc/apache2/ports.conf /etc/apache2/sites-enabled/000-default.conf

# Fix ServerName warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Set index.php as default index file
RUN echo "DirectoryIndex index.php" >> /etc/apache2/apache2.conf

# Redirect root "/" to "/admin/"
RUN echo "RedirectMatch ^/$ /admin/" > /etc/apache2/conf-available/redirect.conf && a2enconf redirect

COPY . /var/www/html/

RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R 755 /var/www/html/

EXPOSE 8080
