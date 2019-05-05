.PHONY: build push run run-echo

TAG=latest
IMAGE=crusttech/webapp

build:
	docker build --no-cache -t $(IMAGE):$(TAG) --build-arg BRANCH=beta .

push:
	docker push $(IMAGE):$(TAG)

run:
	docker run --rm -it -e VIRTUAL_HOST="test" -P $(IMAGE):$(TAG)

run-echo:
	docker run --rm -it -e VIRTUAL_HOST="test" $(IMAGE):$(TAG) echo Hello world