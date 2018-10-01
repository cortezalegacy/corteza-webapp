.PHONY: docker push

TAG=latest
IMAGE=crusttech/webapp

build:
	docker build -t $(IMAGE):$(TAG) .

push:
	docker push $(IMAGE):$(TAG)

run:
	docker run --rm -it --publish 80 $(IMAGE):$(TAG)