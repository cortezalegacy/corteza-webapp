.PHONY: docker push

TAG=latest
IMAGE=crusttech/webapp

build:
	docker build -t $(IMAGE):$(TAG) --build-arg BRANCH=beta .

push:
	docker push $(IMAGE):$(TAG)

run:
	docker run --rm -it --publish 80 $(IMAGE):$(TAG)