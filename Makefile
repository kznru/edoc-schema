REGISTRY=registry.headmade.pro
COMPOSE_CMD=docker-compose --project-name $(PROJECT_NAME) -f compose_test/docker-compose.yml

#######################################

set_host:
	find schemas/generated_schemas -name '*.json' -exec sed -ie "s/edoc-schema.kzn.ru/$(VIRTUAL_HOST)/g" {} \;

run_web:
	@make set_host
	bundle exec jekyll serve --port 80 --host 0.0.0.0

run_local:
	@make set_host
	bundle exec jekyll s

#######################################

test:
	@echo 'export DEPLOY_HOST=register-smp'
	@echo 'export PROJECT_NAME=edoc'

local:
	@echo 'export VIRTUAL_HOST=localhost:4000'

#######################################

restart: compose.pull compose.down compose.upd
deploy: compose.pull compose.upd
ps: compose.ps
down: compose.pull compose.down

#######################################

build:
	docker build -f Dockerfile.test -t edoc-schema .
	docker tag edoc-schema:latest $(REGISTRY)/edoc-schema:latest
	docker push $(REGISTRY)/edoc-schema:latest


compose.pull: DEPLOY_HOST!
	@make compose.cmd CMD='pull'

compose.upd: DEPLOY_HOST!
	@make compose.cmd CMD='up -d'

compose.ps: DEPLOY_HOST!
	@make compose.cmd CMD='ps'

compose.down: DEPLOY_HOST!
	@make compose.cmd CMD='down'

compose.cmd: DEPLOY_HOST! CMD!
	@eval $$(docker-machine env $(DEPLOY_HOST)) ;\
	echo "$(COMPOSE_CMD) $(CMD)" ;\
	$(COMPOSE_CMD) $(CMD)

deploy.new.docker: DEPLOY_HOST!
	# user 'deploy' must have sudo without password
	docker-machine create --driver generic --generic-ip-address=$(DEPLOY_HOST) --generic-ssh-user=hm $(DEPLOY_HOST)

%!:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* is not set"; \
		exit 1; \
	fi
