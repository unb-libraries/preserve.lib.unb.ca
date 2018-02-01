FROM python:3-alpine

RUN apk add --update \
    libffi-dev \
    build-base \
    python-dev \
    curl \
    openssl-dev \
    && pip install cffi pywb \
    && mkdir /app

COPY ./templates /app/templates
COPY ./scripts /scripts

RUN cp ./scripts/sync-header.sh /etc/periodic/15min/sync-header

WORKDIR /app

CMD ["/scripts/run.sh"]
