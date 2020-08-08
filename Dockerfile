FROM composer:2

# RUN apk add --no-cache nodejs nodejs-npm

WORKDIR /project

RUN composer global require "phpstan/phpstan"
RUN composer global require "phpstan/phpstan-strict-rules"
RUN composer global require "phpstan/phpstan-phpunit"
RUN composer global require "phpstan/extension-installer"
RUN composer global require "squizlabs/php_codesniffer"

RUN mkdir /project/code

COPY code/composer.lock code
COPY code/composer.json code
COPY code/database code/database
COPY code/tests code/tests
RUN cd code && composer install

COPY phpstan.neon .
COPY Makefile .
COPY code ./code

ENV PATH $COMPOSER_HOME/vendor/bin:$PATH
