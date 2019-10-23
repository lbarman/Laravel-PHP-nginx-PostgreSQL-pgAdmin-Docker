build:
	docker-compose up --build

serve:
	docker-compose up

rebuild-db:
	docker exec php php artisan migrate

seed:
	docker exec php php artisan db:seed

clean-data:
	rm -rf db/data/data/*
	rm -rf db_admin/data/*

test: 
	# todo add unit tests
	docker exec php php artisan dusk

build-db-and-test: rebuild-db seed test

.PHONY: serve rebuild-d seed test clean-data