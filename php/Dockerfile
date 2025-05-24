FROM laravel-base:php81

WORKDIR /var/www

COPY . .

RUN composer install
RUN npm install --force && npm run dev

RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
