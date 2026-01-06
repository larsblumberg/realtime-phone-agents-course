FROM python:3.11-slim

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

RUN apt-get update && \
    apt-get install -y ffmpeg libgl1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Python deps
COPY uv.lock pyproject.toml README.md ./
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --link-mode=copy

# App code
COPY src src/

CMD ["/app/.venv/bin/uvicorn", "realtime_phone_agents.api.main:app", "--host", "0.0.0.0", "--port", "8000", "--loop", "asyncio"]
