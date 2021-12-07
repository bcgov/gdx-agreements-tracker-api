FROM postgres:14-alpine

ENV RUNUSER postgres
ENV HOME /postgresql
ENV PGDATA /postgresql/data

# Add docker-entrypoint script base
COPY docker-entrypoint.tar.gz /docker-entrypoint.tar.gz

RUN set -ex; \
    apk add --no-cache tar ; \
    tar zxvf docker-entrypoint.tar.gz ; \
    rm -f docker-entrypoint.tar.gz ; \
    chmod -R 555 /docker-entrypoint.* ; \
    chmod 664 /etc/passwd /etc/group /etc/shadow ; \
    chown 0:0 /etc/shadow ; \
    chmod 775 /etc ; \
    mkdir /postgresql ; \
    chown 0:0 /postgresql ; \
    chmod 775 /postgresql ; \
    deluser postgres; \
    apk del tar

VOLUME /postgresql


