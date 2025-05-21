FROM php:8.2-apache

# Install MySQLi extension
RUN docker-php-ext-install mysqli

# Make Apache use port 8080
RUN sed -i 's/80/8080/g' /etc/apache2/ports.conf /etc/apache2/sites-enabled/000-default.conf

# Set index.php as the default directory index
RUN echo "DirectoryIndex index.php" >> /etc/apache2/apache2.conf

# Redirect root (/) to /admin/
RUN echo "RedirectMatch ^/$ /admin/" > /etc/apache2/conf-available/redirect.conf && a2enconf redirect

# Copy app files to web root
COPY . /var/www/html/

# ✅ Fix: Set proper ownership so Apache can read the files
RUN chown -R www-data:www-data /var/www/html/

# Expose port Railway connects to
EXPOSE 8080
