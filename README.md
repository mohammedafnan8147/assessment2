# BERT for Evidence Retrieval and Claim Verification

This repository contains the code for the ECIR 2020 paper. It is a training project, not a hosted web app. The upstream project does not include the FEVER training data, so you must provide the prepared TSV files before training.

## Fastest setup: GitHub Codespaces

1. Fork this repository to your GitHub account.
2. Open your fork and choose **Code → Codespaces → Create codespace on master**. The included dev container installs the legacy Python and CPU dependencies.
3. In the Codespaces terminal, create `data/` and add these prepared evidence-retrieval files:
   - `train_sentences_pos.tsv`
   - `train_sentences_neg_32.tsv`
   - `dev_sentences.tsv`
4. Run:

   ```bash
   bash scripts/run_evidence_retrieval.sh
   ```

The first run downloads the `bert-base-uncased` model. Checkpoints and evaluation output are written under `outputs/` and are excluded from Git.

## Output from a successful run

The terminal shows training progress, the run's training loss, and `Storing dev scores` when evaluation finishes. Each run creates a timestamped folder under `outputs/`, for example:

```text
outputs/
└── retrieval-<timestamp>/
    ├── config.json
    ├── pytorch_model.bin
    ├── scores.p
    └── vocab.txt
```

`pytorch_model.bin` contains the trained model weights, `config.json` and `vocab.txt` are used to load the model, and `scores.p` contains the serialized prediction scores for the development examples. The exact loss value depends on your data and run.

To find the newest run and inspect its files in the Codespaces terminal:

```bash
ls -lt outputs/
ls -lh outputs/retrieval-<timestamp>/
```

Replace `<timestamp>` with the folder name shown by `ls`. These files stay in your Codespace and are not committed to Git automatically.

### Data

The TSVs are not included for licensing reasons. Get FEVER and prepare the sentence-pair TSVs using the [FEVER dataset](https://github.com/sheffieldnlp/fever-naacl-2018) and a document/sentence retrieval pipeline such as [UKP-Athene](https://github.com/UKPLab/fever-2018-team-athene). Each TSV needs a header row; `data_samples.txt` shows the columns and example rows expected by the retrieval script. Keep the data local in `data/`; do not commit the dataset to GitHub.

### Claim verification

After preparing the claim-verification TSVs (`train.tsv`, `train_negative.tsv`, and `dev.tsv`), run:

```bash
bash scripts/run_claim_verification.sh
```

The script uses `run_classifier_negativemining.py` and writes results to a new directory under `outputs/`.

## Run outside Codespaces

Use a Linux x86-64 environment with Python 3.7. Install the pinned dependencies and NLTK tokenizer data:

```bash
python -m pip install --upgrade "pip<24.1"
python -m pip install --no-cache-dir -f https://download.pytorch.org/whl/cpu/torch_stable.html -r requirements.txt
python -m nltk.downloader punkt
bash scripts/run_evidence_retrieval.sh
```

For model training, a supported GPU environment is much faster. Standard Codespaces machine types may be CPU-only; [GitHub notes](https://docs.github.com/en/codespaces/developing-a-codespace/getting-started-with-github-codespaces-for-machine-learning) that GPU Codespaces are not generally available.

## Original paper and code

The code is from [BERT for Evidence Retrieval and Claim Verification](https://link.springer.com/chapter/10.1007/978-3-030-45442-5_45), published at ECIR 2020. The scripts use the original `pytorch-pretrained-bert` package and legacy dependencies so the published implementation remains reproducible.
