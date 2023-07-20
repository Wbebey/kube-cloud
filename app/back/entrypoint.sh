#!/bin/bash

echo "----------->>>>>>>>>>>> Start script"

doppler run -- composer install

doppler run -- php artisan migrate --seed --force

doppler run -- php-fpm


