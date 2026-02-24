FROM php:8.2-apache

# Install required PHP extensions and Apache modules.
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && docker-php-ext-install pdo pdo_mysql \
    && a2enmod rewrite headers \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

# Ensure Apache can read .htaccess / rewritten routes if needed.
RUN printf "<Directory /var/www/html>\n    AllowOverride All\n    Require all granted\n</Directory>\n" > /etc/apache2/conf-available/ecommerce.conf \
    && a2enconf ecommerce

# Copy application code.
COPY . /var/www/html

# Runtime writable paths.
RUN mkdir -p /var/www/html/uploads /var/www/html/tmp \
    && chown -R www-data:www-data /var/www/html/uploads /var/www/html/tmp

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
  CMD curl -fsS http://localhost/index.php || exit 1
