RAILS_ENV ?= development
PROJECT_NAME := interview-api
RUN := run --rm
DOCKER_COMPOSE_FILES := -f docker-compose.yml
DOCKER_COMPOSE := docker-compose $(DOCKER_COMPOSE_FILES) --project-name $(PROJECT_NAME)
DOCKER_COMPOSE_RUN := $(DOCKER_COMPOSE) $(RUN)
WEB_CONCURRENCY := 0

default: bin-rspec

bin-rspec:
	bin/rspec

provision: bundle db-migrate

up:
	rm -f tmp/pids/server.pid && ${DOCKER_COMPOSE} up

api:
	${DOCKER_COMPOSE_RUN} --service-ports -e "WEB_CONCURRENCY=${WEB_CONCURRENCY}" api

db-migrate:
	${DOCKER_COMPOSE_RUN} -e "RAILS_ENV=${RAILS_ENV}" app bundle exec rake db:migrate

db-rollback:
	${DOCKER_COMPOSE_RUN} -e "RAILS_ENV=${RAILS_ENV}" app bundle exec rake db:rollback

db-seed:
	${DOCKER_COMPOSE_RUN} -e "RAILS_ENV=${RAILS_ENV}" app bundle exec rake db:seed

bash:
	${DOCKER_COMPOSE_RUN} -e "RAILS_ENV=${RAILS_ENV}" app bash

rails-console:
	${DOCKER_COMPOSE_RUN} -e "RAILS_ENV=${RAILS_ENV}" app bundle exec rails c

job:
	${DOCKER_COMPOSE_RUN} sidekiq

compose:
	${DOCKER_COMPOSE} ${CMD}

down:
	${DOCKER_COMPOSE} down

down-v:
	${DOCKER_COMPOSE} down -v

bundle:
	${DOCKER_COMPOSE_RUN} app bundle ${CMD}

test:
	${DOCKER_COMPOSE_RUN} -e "RAILS_ENV=test" app bundle exec rspec ${T}

psql:
	${DOCKER_COMPOSE_RUN} app psql postgresql://postgres@db/interview_${RAILS_ENV}

build:
	${DOCKER_COMPOSE} build

rebuild:
	${DOCKER_COMPOSE} build --force-rm

rubocop:
	${DOCKER_COMPOSE_RUN} app rubocop

ps:
	${DOCKER_COMPOSE} ps
