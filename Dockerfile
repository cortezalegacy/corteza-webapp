FROM node:8-alpine AS builder
RUN mkdir -p /crust /build
WORKDIR /crust

ENV BRANCH master

ADD https://github.com/crusttech/webapp-chrome/archive/${BRANCH}.zip    /build/webapp-chrome.zip
ADD https://github.com/crusttech/webapp-crm/archive/${BRANCH}.zip       /build/webapp-crm.zip
ADD https://github.com/crusttech/webapp-messaging/archive/${BRANCH}.zip /build/webapp-messaging.zip

ADD *.sh /build/
RUN sh /build/build.sh ${BRANCH}

FROM nginx:1.15-alpine AS production

COPY nginx.conf /etc/nginx/nginx.conf
RUN nginx -t

COPY --from=builder /crust /crust

EXPOSE 80

RUN chown nginx.nginx /usr/share/nginx/html/ -R
