FROM python:3.8-slim as builder

WORKDIR /wheels
COPY ./requirements.txt /wheels/requirements.txt
RUN apt-get update && \
    apt-get install -y libgdal-dev g++ && \
    rm -rf /var/lib/apt/lists/* && \
    pip install -U pip && \
    pip wheel -r ./requirements.txt

FROM python:3.8-slim
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY --from=builder /wheels /wheels

RUN apt-get update && \
    apt-get install -y libpq-dev gdal-bin && \
    rm -rf /var/lib/apt/lists/* && \
    pip install -U pip && \
    pip install -r /wheels/requirements.txt \
                -f /wheels && \
    rm -rf /wheels && \
    rm -rf /root/.cache/pip/*

ADD . /app
WORKDIR /app

CMD python manage.py runserver 0.0.0.0:8000