
# --------------- DEV ----------------

build: all-dockers-down
	docker-compose -f ./docker-compose-testing.yml build --pull

serve: build
	docker-compose -f ./docker-compose-testing.yml up

# --------------- PROD ----------------

build-prod: all-dockers-down
	docker-compose -f ./docker-compose-production.yml build --pull

serve-prod: build-prod
	docker-compose -f ./docker-compose-production.yml up

# --------------- TESTING ----------------

test: clear-cache
	# returns 0 iff "php" container is running
	docker inspect -f '{{.State.Running}}' php
	$(MAKE) -C . test-unit
	$(MAKE) -C . test-integration

test-unit:
	docker exec php phpunit

test-integration:
	docker exec php php artisan dusk || docker exec php dusk-failure-report.sh

# --------------- CLEANUP ----------------

all-dockers-down:
	docker-compose -f ./docker-compose-testing.yml down
	docker-compose -f ./docker-compose-production.yml down

clear-cache:
	docker exec php php artisan config:cache

clear-db-data:
	rm -rf db/data-testing/data/*
	rm -rf db_admin/data-testing/*

# --------------- Travis and automated install ----------------

wait-for-serve:
	./utils/wait-for-docker-container.sh

php-install:
	# need to be called AFTER having mapped a volume on top of /website (which masks /website/vendor)
	docker exec php composer install --prefer-source --no-interaction 

rebuild-db: clear-cache
	docker exec php php artisan migrate

# --------------- Manual Operations ----------------

host-vscode-setup:
	sudo dnf install -y php php-json php-xdebug
	$(info "Install PHP Debug and PHP IntelliSense from Felix Becker in VS Code, and phpfmt extension.")

seed:
	docker exec php php artisan db:seed

composer-update:
	docker exec php composer install
	docker exec php composer update

# all rules are phony, no exception
.PHONY: build build-prod all-dockers-down serve serve-prod rebuild-db seed clear-db-data php-install wait-for-serve clear-cache test test-unit test-integration composer-update