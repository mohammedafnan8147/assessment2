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

## Example output

After the retrieval script completes, the console includes lines like these:

```text
printing loss
training_loss~= <loss value from your run>
Storing dev scores
```

The loss is calculated from your training data and can vary between runs. The placeholder above is not a measured result.

Each run saves model and evaluation files in a timestamped folder, for example:

```text
outputs/
└── retrieval-<timestamp>/
    ├── config.json
    ├── pytorch_model.bin
    ├── scores.p
    └── vocab.txt
```

In the Codespaces terminal, list the newest run and its files:

```bash
latest_output=$(ls -dt outputs/retrieval-* | head -n 1)
echo "$latest_output"
ls -lh "$latest_output"
```
