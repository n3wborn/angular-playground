PWD = $(shell pwd)
PORTS1 = 4200:4200
PORTS2 = 49153:49153
NODE-IMAGE = node:lts-slim
PKG_MANAGER = npm
CONTAINER_NAME = angular-container

%:
	@:

.PHONY: start
start:
	docker run --rm -it \
		-p $(PORTS1) -p $(PORTS2) \
		--name $(CONTAINER_NAME) \
		-u "node" \
		-w /home/node/app \
		-v $(PWD)/angular-app:/home/node/app \
		$(NODE-IMAGE) \
		$(PKG_MANAGER) run start

.PHONY: install
install:
	docker run --rm -it \
		-u "node" \
		-w /home/node/app \
		-v $(PWD)/angular-app:/home/node/app \
		$(NODE-IMAGE) \
		$(PKG_MANAGER) install

.PHONY: bash
bash:
	docker exec -it $(CONTAINER_NAME) bash

.PHONY: add_dev_deps
add_dev_deps:
	docker exec -it $(CONTAINER_NAME) $(PKG_MANAGER) install $(filter-out $@,$(MAKECMDGOALS)) --dev

.PHONY: add_deps
add_deps:
	docker exec -it $(CONTAINER_NAME) $(PKG_MANAGER) install $(filter-out $@,$(MAKECMDGOALS))

.PHONY: rm_deps
rm_deps:
	docker exec -it $(CONTAINER_NAME) $(PKG_MANAGER) remove $(filter-out $@,$(MAKECMDGOALS))

.PHONY: rm_dev_deps
rm_dev_deps:
	docker exec -it $(CONTAINER_NAME) $(PKG_MANAGER) remove $(filter-out $@,$(MAKECMDGOALS)) --dev

