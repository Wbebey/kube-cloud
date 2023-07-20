FROM php:7.4-fpm

ARG DOPPLER_TOKEN
ARG APP
ARG ENV_NAME

ENV APP=${APP}
ENV DOPPLER_TOKEN=${DOPPLER_TOKEN}
ENV ENV_NAME=${ENV_NAME}

RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
        git \
        curl

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql exif pcntl bcmath gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg && \
    curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | apt-key add - && \
    echo "deb https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list && \
    apt-get update && \
    apt-get -y install doppler

RUN doppler setup --token ${DOPPLER_TOKEN} --project ${APP} --config ${ENV_NAME} 

EXPOSE 9000

# ENV ELASTICSEARCH_URI http://elasticsearch:9200

# Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD curl --fail http://localhost:8080/api/v1 || exit 1

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]