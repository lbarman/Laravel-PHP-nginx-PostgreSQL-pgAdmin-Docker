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

test: 
	# todo add unit tests
	docker exec php php artisan dusk

build-db-and-test: rebuild-db seed test

.PHONY: serve rebuild-d seed test clean-data