FROM nginx:1.15-alpine as builder

COPY build.sh webapp-*.tar.bz2 /crust/
WORKDIR /crust
RUN sh build.sh


FROM nginx:1.15-alpine

COPY files/ /
COPY --from=builder /crust/webapp /crust/webapp

RUN nginx -t

ENTRYPOINT ["/start.sh"]
