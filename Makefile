
# --------------- DEV ----------------

build:
	docker-compose -f ./docker-compose-testing.yml down
	docker-compose -f ./docker-compose-production.yml down
	docker-compose -f ./docker-compose-testing.yml build --pull

serve: build
	docker-compose -f ./docker-compose-testing.yml up

# --------------- PROD ----------------

build-prod:
	docker-compose -f ./docker-compose-testing.yml down
	docker-compose -f ./docker-compose-production.yml down
	docker-compose -f ./docker-compose-production.yml build --pull

serve-prod: build-prod
	docker-compose -f ./docker-compose-production.yml up

# --------------- TESTING ----------------

test: clear-cache
	# returns 0 iff "php" container is running
	docker inspect -f '{{.State.Running}}' php
	$(MAKE) -C . test-unit
	$(MAKE) -C . test-integration

clear-cache:
	docker exec php php artisan config:cache

test-unit:
	docker exec php phpunit

test-integration:
	docker exec php php artisan dusk

# --------------- TOOLS ----------------

host-vscode-setup:
	sudo dnf install -y php php-json php-xdebug
	$(info "Install PHP Debug and PHP IntelliSense from Felix Becker in VS Code.")

rebuild-db: clear-cache
	docker exec php php artisan migrate

seed:
	docker exec php php artisan db:seed

clean-data:
	rm -rf db/data-testing/data/*
	rm -rf db_admin/data-testing/*

wait-for-serve:
	./utils/wait-for-docker-container.sh

php-install:
	# useful after having mapped a volume on top of /website (masking /website/vendor)
	docker exec php composer install --prefer-source --no-interaction 

update:
	docker exec php composer update

.PHONY: build build-prod serve serve-prod rebuild-db seed clean-data php-install wait-for-serve clear-cache test test-unit test-integration