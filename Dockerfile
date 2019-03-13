FROM php:7.0-apache

RUN apt-get update && apt-get install -y libcurl4-gnutls-dev libxml2-dev \
    && pecl install solr \
    && docker-php-ext-enable solr
