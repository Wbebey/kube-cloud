#!/bin/bash

echo "----------->>>>>>>>>>>> Start script"

composer install

php artisan migrate --seed --force

php-fpm


