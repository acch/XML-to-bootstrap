DOCKER=/bin/docker
DOCKER_IMAGE_NAME=acch/x2b

default: build

build:
	$(DOCKER) pull nginx
	$(DOCKER) build -t $(DOCKER_IMAGE_NAME) .

push:
	$(DOCKER) login
	$(DOCKER) push $(DOCKER_IMAGE_NAME)

test:
	$(DOCKER) run --rm $(DOCKER_IMAGE_NAME) /bin/echo "Success."
