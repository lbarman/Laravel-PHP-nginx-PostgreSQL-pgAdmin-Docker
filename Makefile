SHELL=/bin/bash

host-vscode-setup:
	sudo dnf install -y php php-json php-xdebug
	$(info "Install PHP Debug and PHP IntelliSense from Felix Becker in VS Code.")

build:
	docker-compose -f ./docker-compose-testing.yml down
	docker-compose -f ./docker-compose-production.yml down
	docker-compose -f ./docker-compose-testing.yml build --pull

build-prod:
	docker-compose -f ./docker-compose-testing.yml down
	docker-compose -f ./docker-compose-production.yml down
	docker-compose -f ./docker-compose-production.yml build --pull

serve: build
	docker-compose -f ./docker-compose-testing.yml up

serve-prod: build-prod
	docker-compose -f ./docker-compose-production.yml up

rebuild-db:
	docker exec php php artisan migrate

seed:
	docker exec php php artisan db:seed

clean-data:
	rm -rf db/data-testing/data/*
	rm -rf db_admin/data-testing/*

wait-for-serve:
	./utils/wait-for-docker-container.sh

test: 
	# returns 0 iff "php" container is running
	docker inspect -f '{{.State.Running}}' php
	
	docker exec php phpunit
	#docker exec php php artisan dusk

.PHONY: build build-prod serve serve-prod rebuild-db seed clean-data wait-for-serve test