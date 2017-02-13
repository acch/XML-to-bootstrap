DOCKER=/bin/docker
DOCKER_IMAGE_NAME=acch/x2b
DOCKER_BASE_NAME=nginx
DOCKER_BASE_VERSION=latest

default: build

build:
	$(DOCKER) pull $(DOCKER_BASE_NAME):$(DOCKER_BASE_VERSION)
	$(DOCKER) build -t $(DOCKER_IMAGE_NAME) .

push:
	$(DOCKER) login
	$(DOCKER) push $(DOCKER_IMAGE_NAME)

test:
	$(DOCKER) run --rm $(DOCKER_IMAGE_NAME) /bin/echo "Success."

clean:
	$(DOCKER) images -qf dangling=true | xargs --no-run-if-empty docker rmi
