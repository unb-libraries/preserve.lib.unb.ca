FROM python:3.6-alpine

COPY ./app /app
WORKDIR /app

RUN apk add --no-cache curl
RUN apk add --no-cache --virtual build-dependencies \
    libffi-dev \
    build-base \
    python-dev \
    openssl-dev \
    && pip install -r requirements.txt \
    && apk del build-dependencies

COPY ./scripts /scripts

RUN cp /scripts/sync-header.sh /etc/periodic/15min/sync-header

CMD ["/scripts/run.sh"]
