FROM python:3-alpine

RUN apk add --update \
    libffi-dev \
    build-base \
    python-dev \
    curl \
    && pip install cffi pywb \
    && mkdir /app

COPY ./templates /app/templates

WORKDIR /app

CMD ["wayback"]
