# syntax=docker/dockerfile:1
FROM python:3.12-slim-bookworm AS builder

WORKDIR /app
RUN apt-get update \
  && apt-get install -y --no-install-recommends gcc python3-dev libpq-dev \
  && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml ./
COPY src/ ./src/

RUN python -m pip install --no-cache-dir --upgrade pip setuptools wheel
RUN python -m pip install --no-cache-dir .

FROM builder AS test
COPY tests/ ./tests/
RUN python -m pip install --no-cache-dir ".[test]"
CMD ["pytest", "tests"]

FROM python:3.12-slim-bookworm AS runtime

WORKDIR /app
RUN apt-get update \
  && apt-get install -y --no-install-recommends libpq5 \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY src/ ./src/

RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PORT=8120

EXPOSE 8120

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD ["python", "-c", "import urllib.request, os; urllib.request.urlopen('http://127.0.0.1:' + os.getenv('PORT', '8120') + '/users/')"]

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8120"]

