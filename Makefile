DATA_PATH = /home/$(USER)/data

WP_PATH = $(DATA_PATH)/wordpress
DB_PATH = $(DATA_PATH)/mariadb

all:
	mkdir -p $(WP_PATH)
	mkdir -p $(DB_PATH)
	docker-compose up -d --build

down:
	docker-compose down

clean:
	docker-compose down -v
	sudo rm -rf $(WP_PATH)
	sudo rm -rf $(DB_PATH)

re: clean all

.PHONY: all down clean re