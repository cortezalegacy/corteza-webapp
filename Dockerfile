FROM nginx:1.15-alpine as builder

COPY build.sh webapp-*.tar.bz2 /crust/
WORKDIR /crust
RUN sh build.sh

FROM nginx:1.15-alpine

COPY files/ /

# There's a nginx config file under /files, make sure it works
RUN nginx -t

# Make all startup scripts executable
RUN chmod +x /start.d/*

# Copy webapp files
COPY --from=builder /crust/webapp /crust/webapp

ENTRYPOINT ["/entrypoint.sh"]
