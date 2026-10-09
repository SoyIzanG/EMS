
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

RUN mkdir -p /mnt/extra-addons/ems \
    /mnt/extra-addons/queue \
    /mnt/extra-addons/partner-contact

COPY . /mnt/extra-addons/ems/

RUN chown -R odoo:odoo /mnt/extra-addons

USER odoo
