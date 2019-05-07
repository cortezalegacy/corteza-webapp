.PHONY: build push run run-echo

TAG=latest
IMAGE=crusttech/webapp

build:
	docker build --no-cache -t $(IMAGE):$(TAG) .

push:
	docker push $(IMAGE):$(TAG)

run:
	docker run --rm -it -e -P $(IMAGE):$(TAG)

run-echo:
	docker run --rm -it -e $(IMAGE):$(TAG) echo Hello world