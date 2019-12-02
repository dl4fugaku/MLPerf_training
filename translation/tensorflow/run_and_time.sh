#/bin/bash

# This script runs preprocessing on the downloaded data
# and times (exlcusively) training to the target accuracy.

# To use the script:
# run_and_time.sh <random seed 1-5>

TARGET_UNCASED_BLEU_SCORE=25

set -e

export SEED=1

export COMPLIANCE_FILE="/tmp/transformer_compliance_${SEED}.log"
rm -f $COMPLIANCE_FILE
# path to the mlpef_compliance package in local directory,
# if not set then default to the package name for installing from PyPI.
#export MLPERF_COMPLIANCE_PKG=${MLPERF_COMPLIANCE_PKG:-mlperf_compliance}

# Install mlperf_compliance package.
# The mlperf_compliance package is used for compliance logging.
#pip3 install ${MLPERF_COMPLIANCE_PKG}
export PYTHONPATH="$(pwd):$(pwd)/../../compliance:${PYTHONPATH}"
export PYTHONPATH="$(pwd)/transformer:${PYTHONPATH}"

# Run preprocessing (not timed)
# TODO: Seed not currently used but will be in a future PR
#. run_preprocessing.sh ${SEED}
if [ ! -f /home/domke/data/translation/processed_data/vocab.ende.32768 ]; then
	python3.7 -m scorep --nopython ./process_data.py --raw_dir /home/domke/data/translation/raw_data/ --data_dir /home/domke/data/translation/processed_data
fi

# Start timing
START=$(date +%s)
START_FMT=$(date +%Y-%m-%d\ %r)
echo "STARTING TIMING RUN AT ${START_FMT}"

# Run benchmark (training)
#SEED=${1:-1}

echo "Running benchmark with seed ${SEED}"
#. run_training.sh ${SEED} ${TARGET_UNCASED_BLEU_SCORE}
SCOREP_TOTAL_MEMORY=4089446400 SCOREP_ENABLE_PROFILING=true SCOREP_ENABLE_TRACING=false \
OPENBLAS_NUM_THREADS=16 OMP_NUM_THREADS=16 TF_NUM_INTEROP_THREADS=2 TF_NUM_INTRAOP_THREADS=16 \
python3.7 -m scorep --nopython ./transformer/transformer_main.py \
	--train_epochs=1 --random_seed=${SEED} --data_dir=/home/domke/data/translation/processed_data \
	--model_dir=model --params=big --bleu_threshold ${TARGET_UNCASED_BLEU_SCORE} \
	--bleu_source=/home/domke/data/translation/newstest2014.en --bleu_ref=/home/domke/data/translation/newstest2014.de

RET_CODE=$?; if [[ ${RET_CODE} != 0 ]]; then exit ${RET_CODE}; fi

# End timing
END=$(date +%s)
END_FMT=$(date +%Y-%m-%d\ %r)

echo "ENDING TIMING RUN AT ${END_FMT}"

# Report result
result=$(( ${END} - ${START} ))
result_name="transformer"

echo "RESULT,${RESULT_NAME},${SEED},${RESULT},${USER},${START_FMT}"
