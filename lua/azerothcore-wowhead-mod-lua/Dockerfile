FROM python:3.10-slim

WORKDIR /app

COPY *.py /app/
COPY requirements.txt .

RUN pip install --trusted-host pypi.python.org -r requirements.txt

EXPOSE 8000

WORKDIR /app

ENV GUNICORN_BIND_ADDRESS 0.0.0.0:8000
ENV GUNICORN_WORKERS 4
ENV GUNICORN_TIMEOUT 360
ENV GM_USERNAME admin
ENV GM_PASSWORD admin

CMD /usr/local/bin/gunicorn main:app --bind ${GUNICORN_BIND_ADDRESS} --timeout ${GUNICORN_TIMEOUT} --workers ${GUNICORN_WORKERS}

