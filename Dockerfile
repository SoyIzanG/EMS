
FROM odoo:18.0

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    poppler-utils \
    python3-lxml \
    python3-lxml-html-clean \
    python3-phonenumbers \
    python3-openpyxl \
    python3-google-auth \
    python3-googleapi \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch 18.0 \
    https://github.com/OCA/queue.git \
    /mnt/extra-addons/queue \
    && git clone --depth 1 --branch 18.0 \
    https://github.com/OCA/partner-contact.git \
    /mnt/extra-addons/partner-contact

RUN mkdir -p /mnt/extra-addons/ems

COPY . /mnt/extra-addons/ems/

RUN chown -R odoo:odoo /mnt/extra-addons

USER odoo


EXPOSE 10000

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["exec odoo --http-interface=0.0.0.0 --http-port=\"${PORT:-10000}\" --db_host=\"$DB_HOST\" --db_port=\"${DB_PORT:-5432}\" --db_user=\"$DB_USER\" --db_password=\"$DB_PASSWORD\" --addons-path=/usr/lib/python3/dist-packages/odoo/addons,/mnt/extra-addons/queue,/mnt/extra-addons/partner-contact,/mnt/extra-addons/ems --load=web,queue_job --database=ems_db_x3hu --init=ems"]
