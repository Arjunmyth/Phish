# Use Python as the base toy box
FROM python:3.11-slim

# Ask for missing wheels (system dependencies for Chromium)
RUN apt-get update && apt-get install -y \
    wget \
    libglib2.0-0 \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# Put in your Python candy 🍬 (libraries)
COPY requirements.txt .
RUN pip install -r requirements.txt

# Put Playwright’s Chromium browser inside the box
RUN playwright install --with-deps chromium

# Copy your bot code into the box
COPY . /app
WORKDIR /app

# Tell the box what to do when it starts
CMD ["python", "bot.py"]
