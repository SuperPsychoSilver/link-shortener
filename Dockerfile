FROM php:8.2-apache

RUN docker-php-ext-install mysqli

RUN sed -i 's/80/8080/g' /etc/apache2/ports.conf /etc/apache2/sites-enabled/000-default.conf

RUN echo "DirectoryIndex index.php" >> /etc/apache2/apache2.conf

# Temporarily disable redirect for debugging
# RUN echo "RedirectMatch ^/$ /admin/" > /etc/apache2/conf-available/redirect.conf && a2enconf redirect

COPY . /var/www/html/

RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R 755 /var/www/html/

EXPOSE 8080
