#FROM debian:alpine


FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php
#RUN apt update -y && apt upgrade -y

RUN apt install php7.4 -y
RUN apt install php7.4-cli php7.4-common php7.4-curl php7.4-mbstring php7.4-mysql php7.4-xml php7.4-pdo php7.4-sockets
RUN apt install zip unzip php-zip -y
#RUN docker-php-ext-install pdo pdo_mysql sockets
#RUN curl -sS https://getcomposer.org/installer​ | php -- \
#     --install-dir=/usr/local/bin --filename=composer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer


RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
#RUN co
WORKDIR /app
RUN echo "fuck you"
RUN pwd
COPY . .
RUN pwd & ls  

RUN composer install
RUN composer update
RUN composer dump-autoload
#WORKDIR /app/back
#ENV COMPOSER_ALLOW_SUPERUSER=1
#RUN composer install
#RUN composer update
CMD ["php","-S","127.0.0.1:8000", "-t", "public/"]

# CMD ["php","artisan","serve"]
# CMD ["tail","-f"]