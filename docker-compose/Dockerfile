FROM python:3.11.0-slim as python

FROM python as poetry

ENV POETRY_HOME="/opt/poetry"
ENV PATH=$POETRY_HOME/bin:$PATH

RUN python -m venv $POETRY_HOME && \
    $POETRY_HOME/bin/pip install --no-cache-dir poetry==1.2.0

FROM poetry as devtools

WORKDIR /srv/workspace
