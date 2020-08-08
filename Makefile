ENV := development

compose-setup: compose-build compose-install

compose-build:
	docker-compose build

compose-install:
	docker-compose run development make install

compose-bash:
	docker-compose run $(ENV) bash

compose-test:
	docker-compose run test make test

compose-lint:
	docker-compose run test make lint

install:
	composer install

test:
	composer exec --verbose phpunit tests

lint:
	phpcs code
	phpstan --level=6 analyse -c /project/phpstan.neon code
