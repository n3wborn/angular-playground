PWD = $(shell pwd)
PORTS1 = 4200:4200
PORTS2 = 49153:49153
NODE-IMAGE = node:lts-slim
PKG_MANAGER = npm
CONTAINER_NAME = angular-container
IMAGE_NAME := angular-image
SHELL := /bin/bash

%:
	@:

.PHONY: build_image
build_image:
	docker build --no-cache --force-rm -t $(IMAGE_NAME) .

.PHONY: start
start:
	docker run --rm -it \
		-p $(PORTS1) -p $(PORTS2) \
		--name $(CONTAINER_NAME) \
		-u "node" \
		-w /home/node/app \
		-v $(PWD)/angular-app:/home/node/app \
		--name $(CONTAINER_NAME) \
		$(IMAGE_NAME) \
		$(PKG_MANAGER) run start

.PHONY: install_deps
install_deps: build_image
	docker run --rm -it \
		-u "node" \
		-w /home/node/app \
		-v $(PWD)/angular-app:/home/node/app \
		$(IMAGE_NAME) \
		$(PKG_MANAGER) install

.PHONY: install
install: build_image install_deps
	docker run --rm -it \
		-u "node" \
		-w /home/node/app \
		-v $(PWD)/angular-app:/home/node/app \
		--name $(CONTAINER_NAME) \
		$(IMAGE_NAME) \
		$(PKG_MANAGER) run start

.PHONY: bash
bash:
	docker exec -it $(CONTAINER_NAME) bash

.PHONY: ng
ng:
	docker exec -it $(CONTAINER_NAME) ng $(filter-out $@,$(MAKECMDGOALS))

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

