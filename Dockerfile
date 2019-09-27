FROM nginx:1.15-alpine

COPY files/ /
COPY dist/ /webapp

# There's a nginx config file under /files, make sure it works
RUN nginx -t

# Make all startup scripts executable
RUN chmod +x /start.d/*

ENTRYPOINT ["/entrypoint.sh"]
