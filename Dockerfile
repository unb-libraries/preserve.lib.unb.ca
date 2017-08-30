FROM python:3-alpine

RUN apk add --update \
    libffi-dev \
    build-base \
    python-dev \
    curl \
    && pip install cffi pywb \
    && mkdir /app

COPY ./templates /app/templates
COPY ./scripts /scripts

RUN cp ./scripts/sync-hours.sh /etc/periodic/15min/sync-hours

WORKDIR /app

CMD ["/scripts/run.sh"]
