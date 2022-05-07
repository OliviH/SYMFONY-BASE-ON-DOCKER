include .env

default: help

help:  ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

start: ## Start containers.
	@echo "$(COLOR_LIGHT_GREEN)Starting up containers for $(PROJECT_NAME)...$(COLOR_NC)"
	@docker-compose up -d --remove-orphans
	@make docker-logs

status: ## Status of containers
	@docker-compose ps -a

stop: ## Stop containers.
	@echo "$(COLOR_LIGHT_GREEN)Stopping containers for $(PROJECT_NAME)...$(COLOR_NC)"
	@docker-compose stop

yarn: ## Execute yarn command on node container. e.g: make yarn encore dev
	@docker-compose exec -T node bash -c "yarn $(filter-out $@,$(MAKECMDGOALS))"

symfony: ## Execute symfony console command on PHP container. e.g: make symfo "cache:clear"
	@docker-compose exec -T web bash -c "bin/console $(filter-out $@,$(MAKECMDGOALS))"

mysql: ## Open a mysql-cli on MySQL container
	@docker-compose exec -e LINES=$(tput lines) -e COLUMNS=$(tput cols) db mysql -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME}

docker-remove: ## Remove containers.
	@echo "$(COLOR_LIGHT_GREEN)Removing containers for $(PROJECT_NAME)...$(COLOR_NC)"
	@docker-compose down

docker-logs: ## Display logs (stdout) of all containers or the specified one
	@docker-compose logs --tail="20" -f $(filter-out $@,$(MAKECMDGOALS))

exec-shell-web: ## Open a command line in the web container.
	@docker-compose exec web bash

docker-erase: ## Erase project
	@echo "$(COLOR_LIGHT_GREEN)Removing Project $(PROJECT_NAME)...$(COLOR_NC)"
	@make docker-remove
	@sudo rm -Rfv db-data www

# https://stackoverflow.com/a/6273809/1826109
%:
	@:
