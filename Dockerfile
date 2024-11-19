# https://docs.docker.com/engine/reference/builder/

ARG PYTHON_VERSION=3.7
FROM python:${PYTHON_VERSION}-slim as base

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr.
ENV PYTHONUNBUFFERED=1

# Install OpenSSL and other dependencies
#RUN apt-get update && \
#    apt-get install -y --no-install-recommends \
#    libssl-dev \
#    gcc \
#    && apt-get clean \
#    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose the port that the application listens on.
EXPOSE 8000

# Run the application.
CMD export $(cat .env | xargs) && python hello.py
