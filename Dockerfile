FROM python:3.12.4-slim-bullseye
WORKDIR /usr/src/app
COPY . .
RUN apt-get update
RUN apt install -y  tesseract-ocr tesseract-ocr-ind ffmpeg libsm6 libxext6
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Gunicorn configuration
# Async worker with 8 workers and 4 threads
# Keep-alive extended, no timeout
# High worker connections
CMD ["gunicorn", "api:app", "--workers", "8", "--threads", "4", "--worker-class", "gevent", "--keep-alive", "15", "--timeout", "0", "--worker-connections", "2000", "--bind", "0.0.0.0:80"]

EXPOSE 80
