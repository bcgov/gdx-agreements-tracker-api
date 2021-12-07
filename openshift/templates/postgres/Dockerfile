FROM postgres:14-alpine

ENV RUNUSER postgres

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
    mkdir -p /var/lib/pgsql/data ; \
    chown -R 0:0 /var/lib/pgsql ; \
    chmod -R 775 /var/lib/pgsql ; \
    deluser postgres; \
    apk del tar

VOLUME /var/lib/pgsql


