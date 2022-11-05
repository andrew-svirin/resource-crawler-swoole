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
PHP := /usr/bin/php
COMPOSER := /usr/local/bin/composer
PHPMD := ./vendor/bin/phpmd
PHPCS := ./vendor/bin/phpcs
PHPSTAN := ./vendor/bin/phpstan
PHPUNIT := ./vendor/bin/phpunit
YARN := /usr/local/bin/yarn
SYMFONY := /usr/local/bin/symfony

build:
	cd $(DOCKER_DIR) && $(DC_BUILD)

build-no-cache:
	cd $(DOCKER_DIR) && $(DC_BUILD) --no-cache

start:
	cd $(DOCKER_DIR) && $(DC_UP) -d

stop:
	cd $(DOCKER_DIR) && $(DC_DOWN)

restart: stop start

php-ssh:
ssh:
	cd $(DOCKER_DIR) && $(PHP_CLI_CONTAINER_EXEC) $(BASH)

php-ssh-su:
ssh-su:
	cd $(DOCKER_DIR) && $(PHP_CLI_CONTAINER_EXEC_SU) $(BASH)

node-ssh:
	cd $(DOCKER_DIR) && $(NODE_CONTAINER_EXEC) $(BASH)

install: php-install node-install

php-install:
	cd $(DOCKER_DIR) && $(PHP_CLI_CONTAINER_EXEC) $(COMPOSER) install

node-install:
	cd $(DOCKER_DIR) && $(NODE_CONTAINER_EXEC) $(YARN) install

node-serve:
	cd $(DOCKER_DIR) && $(NODE_CONTAINER_EXEC) $(YARN) run dev

swoole-dump-serve:
	cd $(DOCKER_DIR) && $(PHP_CLI_CONTAINER_EXEC) $(PHP) bin/console server:dump

swoole-serve:
	make php-en-swoole && make php-dis-xdebug && \
	cd $(DOCKER_DIR) && $(PHP_CLI_CONTAINER_EXEC) $(PHP) -d variables_order=EGPCS bin/swoole-serve

php-serve:
	make php-dis-swoole && make php-en-xdebug && \
	cd $(DOCKER_DIR) && $(PHP_CLI_CONTAINER_EXEC) $(SYMFONY) server:start --port=9000

php-dis-xdebug:
	cd $(DOCKER_DIR) && $(PHP_CLI_CONTAINER_EXEC_SU) $(BASH) -c " \
	if [ -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini ] ; \
	then \
    	 mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    	/usr/local/etc/php/docker-php-ext-xdebug.ini ; \
	fi;"

php-en-xdebug:
	cd $(DOCKER_DIR) && $(PHP_CLI_CONTAINER_EXEC_SU) $(BASH) -c " \
	if [ -f /usr/local/etc/php/docker-php-ext-xdebug.ini ] ; \
	then \
    	mv /usr/local/etc/php/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini ; \
	fi;"

php-dis-swoole:
	cd $(DOCKER_DIR) && $(PHP_CLI_CONTAINER_EXEC_SU) $(BASH) -c " \
	if [ -f /usr/local/etc/php/conf.d/docker-php-ext-openswoole.ini ] ; \
	then \
    	mv /usr/local/etc/php/conf.d/docker-php-ext-openswoole.ini /usr/local/etc/php/docker-php-ext-openswoole.ini ; \
	fi;"

php-en-swoole:
	cd $(DOCKER_DIR) && $(PHP_CLI_CONTAINER_EXEC_SU) $(BASH) -c " \
	if [ -f /usr/local/etc/php/docker-php-ext-openswoole.ini ] ; \
	then \
    	mv /usr/local/etc/php/docker-php-ext-openswoole.ini /usr/local/etc/php/conf.d/docker-php-ext-openswoole.ini ; \
	fi;"
