FROM python:3.7.17-slim-bullseye

RUN apt-get update \
    && apt-get install -y --no-install-recommends libgomp1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/bert-fever-setup
COPY requirements.txt ./requirements.txt
RUN python -m pip install --upgrade "pip<24.1" \
    && python -m pip install --no-cache-dir \
       -f https://download.pytorch.org/whl/cpu/torch_stable.html \
       -r requirements.txt \
    && python -m nltk.downloader punkt \
    && rm -rf /tmp/bert-fever-setup

WORKDIR /workspaces/BERT_FEVER
