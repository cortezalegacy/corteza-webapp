FROM crusttech/webapp-builder:latest

# No docker tasks, prepare webapp and leave dist files for production stage to pick it up
RUN /crust/entrypoint.sh --branch latest --skip-docker-build --skip-docker-push


FROM nginx:1.15-alpine AS production

COPY --from=build /crust/nginx.conf /etc
RUN nginx -t

RUN mkdir -p /crust
COPY --from=build /crust/dist /crust/webapp

EXPOSE 80

RUN chown nginx.nginx /usr/share/nginx/html/ -R
