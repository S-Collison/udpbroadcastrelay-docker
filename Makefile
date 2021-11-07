REPO_HOST ?= localhost:5000
REPO_NAME ?= udpbroadcastrelay
BUILD_NAME ?= udpbroadcastrelay:build


.PHONY: push
push: build
	TAG=$$(git submodule status udpbroadcastrelay | sed  's/.*(\(.*\)).*/\1/') && \
	docker tag $(BUILD_NAME) $(REPO_HOST)/$(REPO_NAME):$$TAG && \
	docker push $(REPO_HOST)/$(REPO_NAME):$$TAG

.PHONY: build
build: update-submodules
	docker build -t $(BUILD_NAME) .

.PHONY: update-submodules
update-submodules:
	git submodule update --init --recursive
