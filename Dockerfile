FROM ubuntu:24.04

# Cài đặt các phụ thuộc cần thiết (thêm python3-venv để fix lỗi pip)
RUN apt-get update && apt-get install -y \
    texlive-base \
    texlive-latex-extra \
    texlive-pictures \
    ghostscript \
    poppler-utils \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Nâng cấp pip để tránh lỗi khi cài requirements
RUN python3 -m pip install --upgrade pip

WORKDIR /app
COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
