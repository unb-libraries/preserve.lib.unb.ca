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

RUN echo '*/15 * * * * root /scripts/sync-header.sh' > /etc/cron.d/header && service cron start

CMD ["/scripts/run.sh"]
