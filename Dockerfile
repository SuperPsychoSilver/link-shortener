FROM php:8.2-apache

RUN docker-php-ext-install mysqli

# Change Apache to listen on port 8080
RUN sed -i 's/80/8080/g' /etc/apache2/ports.conf /etc/apache2/sites-enabled/000-default.conf

# Change Apache DocumentRoot to /var/www/html/admin
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/admin|' /etc/apache2/sites-available/000-default.conf

# Update Directory directive for admin folder in apache2.conf
RUN sed -i 's|<Directory /var/www/html>|<Directory /var/www/html/admin>|' /etc/apache2/apache2.conf

# Add explicit Directory directive for /var/www/html/user to allow access
RUN echo "<Directory /var/www/html/user>\n    Options Indexes FollowSymLinks\n    AllowOverride None\n    Require all granted\n</Directory>" >> /etc/apache2/apache2.conf

# Set index.php as the default index file globally
RUN echo "DirectoryIndex index.php" >> /etc/apache2/apache2.conf

# Copy your entire project into the container
COPY . /var/www/html/

# Fix ownership and permissions
RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R 755 /var/www/html/

EXPOSE 8080
