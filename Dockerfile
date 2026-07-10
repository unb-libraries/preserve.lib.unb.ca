FROM python:3.9-slim

COPY build/app /app
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    curl \
    cron \
    && pip install -r requirements.txt \
    && apt-get purge --auto-remove -y build-essential python3-dev

COPY build/scripts /scripts

RUN echo '*/15 * * * * root /scripts/sync-header.sh' > /etc/cron.d/header

# Metadata
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL ca.unb.lib.generator="pywb" \
      org.opencontainers.image.title="preserve.lib.unb.ca" \
      org.opencontainers.image.description="preserve.lib.unb.ca serves and archives legacy websites that have been created or hosted by UNB Libraries." \
      org.opencontainers.image.vendor="University of New Brunswick Libraries" \
      org.opencontainers.image.url="https://preserve.lib.unb.ca" \
      org.opencontainers.image.source="https://github.com/unb-libraries/preserve.lib.unb.ca" \
      org.opencontainers.image.revision="$VCS_REF" \
      org.opencontainers.image.version="$VERSION" \
      org.opencontainers.image.created="$BUILD_DATE"

CMD cron && "/scripts/run.sh"
