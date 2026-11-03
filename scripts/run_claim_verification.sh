#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_DIR="${1:-$ROOT_DIR/data}"
OUTPUT_DIR="${2:-$ROOT_DIR/outputs/claim-verification-$(date +%Y%m%d-%H%M%S)}"

required_files=("train.tsv" "train_negative.tsv" "dev.tsv")
for file in "${required_files[@]}"; do
  if [[ ! -f "$DATA_DIR/$file" ]]; then
    echo "Missing $DATA_DIR/$file" >&2
    echo "Add the prepared claim-verification TSVs before training." >&2
    exit 1
  fi
done

exec python -u "$ROOT_DIR/run_classifier_negativemining.py" \
  --task_name fever \
  --do_train \
  --do_eval \
  --data_dir "$DATA_DIR" \
  --do_lower_case \
  --bert_model bert-base-uncased \
  --max_seq_length 128 \
  --train_batch_size 32 \
  --negative_batch_size 128 \
  --learning_rate 2e-5 \
  --num_train_epochs 2.0 \
  --output_dir "$OUTPUT_DIR"
