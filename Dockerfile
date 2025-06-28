FROM python:3.12-slim-bookworm

# Cài đặt các gói phụ thuộc và texlive
RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-base \
    texlive-latex-extra \
    texlive-pictures \
    ghostscript \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# Update pip
RUN python -m pip install --upgrade --no-cache-dir pip

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
