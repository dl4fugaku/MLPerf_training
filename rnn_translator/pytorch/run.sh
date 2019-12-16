#!/bin/bash

set -e

export PATH="$HOME/.local/bin:$PATH"
export PYTHONPATH="$HOME/MLPerf_training/compliance:${PYTHONPATH}"
DATASET_DIR='/home/domke/data/rnn_translator' #'/data'

SEED=1 #${1:-"1"}
TARGET=24.00 #${2:-"24.00"}

# run training
SCOREP_TOTAL_MEMORY=4089446400 SCOREP_ENABLE_PROFILING=true SCOREP_ENABLE_TRACING=false \
OPENBLAS_NUM_THREADS=16 OMP_NUM_THREADS=16 \
python3.7 -m scorep --nopython train.py \
  --dataset-dir ${DATASET_DIR} \
  --seed $SEED \
  --target-bleu $TARGET \
  --no-cuda --start-epoch 0 --epochs 1
