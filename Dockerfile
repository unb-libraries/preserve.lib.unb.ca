FROM python:3.7-slim

COPY ./app /app
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    curl \
    cron \
    && pip install -r requirements.txt \
    && apt-get purge --auto-remove -y build-essential python3-dev

COPY ./scripts /scripts

RUN echo '*/15 * * * * root /scripts/sync-header.sh' > /etc/cron.d/header

# Metadata
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL ca.unb.lib.generator="pywb" \
      com.microscaling.docker.dockerfile="/Dockerfile" \
      com.microscaling.license="MIT" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.description="preserve.lib.unb.ca serves and archives legacy websites that have been created or hosted by UNB Libraries." \
      org.label-schema.name="preserve.lib.unb.ca" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.url="https://preserve.lib.unb.ca" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/unb-libraries/preserve.lib.unb.ca" \
      org.label-schema.vendor="University of New Brunswick Libraries" \
      org.label-schema.version=$VERSION

CMD cron && "/scripts/run.sh"
