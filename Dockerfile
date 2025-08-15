FROM python:3.12.8-slim

ARG DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY ./ ./

RUN pip install --no-cache-dir poetry==1.8.5 \
 && poetry install --only main

# Porta padrão (opcional, ajuda em ambientes sem PORT)
ENV PORT=8000
EXPOSE 8000

# Use shell para expandir ${PORT:-8000} e faça exec para repassar sinais corretamente
CMD ["sh", "-c", "exec poetry run uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000}"]
