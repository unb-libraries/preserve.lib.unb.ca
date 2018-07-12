FROM python:3.6-alpine

COPY ./app /app
WORKDIR /app

RUN apk add --update \
    libffi-dev \
    build-base \
    python-dev \
    curl \
    openssl-dev \
    && pip install -r requirements.txt

COPY ./scripts /scripts

RUN cp /scripts/sync-header.sh /etc/periodic/15min/sync-header

CMD ["/scripts/run.sh"]
