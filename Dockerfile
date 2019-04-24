FROM nginx:1.15-alpine

RUN mkdir -p /crust
WORKDIR /crust

COPY nginx.conf /etc/nginx/
RUN nginx -t

COPY build.sh webapp-*.tar.bz2 /crust/
RUN cd /crust && sh build.sh && mv dist webapp

COPY start.sh /crust/

CMD ["sh", "/crust/start.sh"]
