FROM php:8.2-apache

# Apache用Rewriteモジュール有効化
RUN a2enmod rewrite

# System update & 必要なPHP拡張のインストール
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo_mysql zip gd mbstring

# Composerインストール
# Composerをインストール
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# ApacheのDocumentRootをLaravel用に指定（publicディレクトリ）
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/000-default.conf

# ソースコードをコンテナ内へコピー
COPY . /var/www/html

# 権限整理
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

WORKDIR /var/www/html

# APP_KEY生成
RUN composer install --no-dev --optimize-autoloader
RUN cp .env.example .env && php artisan key:generate

EXPOSE 80
CMD ["apache2-foreground"]