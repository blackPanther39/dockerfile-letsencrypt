from debian:latest
RUN apt-get update \
    && apt-get install -y \
        git-core
run git clone https://github.com/certbot/certbot /opt/letsencrypt/src
run /opt/letsencrypt/src/letsencrypt-auto-source/letsencrypt-auto --os-packages-only && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
           /tmp/* \
           /var/tmp/*

RUN virtualenv --no-site-packages -p python3 /opt/letsencrypt/venv && \
    /opt/letsencrypt/venv/bin/pip install \
    --upgrade setuptools \
    -e /opt/letsencrypt/src/acme \
    -e /opt/letsencrypt/src/certbot \
    -e /opt/letsencrypt/src/certbot-apache \
    -e /opt/letsencrypt/src/certbot-nginx

ENV PATH /opt/letsencrypt/venv/bin:$PATH

ENTRYPOINT [ "certbot" ]
