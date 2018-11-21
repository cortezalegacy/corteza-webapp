FROM crusttech/webapp-dev AS builder

RUN mkdir -p /crust /build
WORKDIR /crust

ARG BRANCH=latest

ADD build/*.sh /build/
RUN sh /build/build.sh $BRANCH

FROM nginx:1.15-alpine AS production

ADD build/etc/ /etc
RUN nginx -t

COPY --from=builder /crust /crust

EXPOSE 80

RUN chown nginx.nginx /usr/share/nginx/html/ -R
