DOCKER_DIR := infrastructure/docker
DC := docker-compose
DC_BUILD := $(DC) build
DC_UP := $(DC) up
DC_DOWN := $(DC) down
DC_EXEC := $(DC) exec
PHP_CLI_CONTAINER := php-cli-resource-crawler-swoole
PHP_CLI_CONTAINER_EXEC := $(DC_EXEC) $(PHP_CLI_CONTAINER)
PHP_CLI_CONTAINER_EXEC_SU := $(DC_EXEC) --user=root $(PHP_CLI_CONTAINER)
NODE_CONTAINER := node-resource-crawler-swoole
NODE_CONTAINER_EXEC := $(DC_EXEC) $(NODE_CONTAINER)
BASH := /bin/bash
COMPOSER := /usr/local/bin/composer
PHPMD := ./vendor/bin/phpmd
PHPCS := ./vendor/bin/phpcs
PHPSTAN := ./vendor/bin/phpstan
PHPUNIT := ./vendor/bin/phpunit
NODE := /usr/local/bin/node
YARN := /usr/local/bin/yarn
NPX := /usr/local/bin/npx

build:
	cd $(DOCKER_DIR) && $(DC_BUILD)

build-no-cache:
	cd $(DOCKER_DIR) && $(DC_BUILD) --no-cache

start:
	cd $(DOCKER_DIR) && $(DC_UP) -d

stop:
	cd $(DOCKER_DIR) && $(DC_DOWN)

restart: stop start

ssh:
	cd $(DOCKER_DIR) && $(PHP_CLI_CONTAINER_EXEC) $(BASH)

ssh-su:
	cd $(DOCKER_DIR) && $(PHP_CLI_CONTAINER_EXEC_SU) $(BASH)

node-ssh:
	cd $(DOCKER_DIR) && $(NODE_CONTAINER_EXEC) $(BASH)

install: php-install node-install

php-install:
	cd $(DOCKER_DIR) && $(PHP_CLI_CONTAINER_EXEC) $(COMPOSER) install

node-install:
	cd $(DOCKER_DIR) && $(NODE_CONTAINER_EXEC) $(YARN) install

node-watch:
	cd $(DOCKER_DIR) && $(NODE_CONTAINER_EXEC) $(NPX) vue-cli-service serve --host=0.0.0.0 --port=9000