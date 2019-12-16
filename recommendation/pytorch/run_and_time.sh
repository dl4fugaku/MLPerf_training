#!/bin/bash
set -e

# runs benchmark and reports time to convergence
# to use the script:
#   run_and_time.sh <random seed 1-5>

THRESHOLD=1.0
BASEDIR="$HOME/data/recommendation" #'/data/cache'
DATASET=${DATASET:-ml-1m} #${DATASET:-ml-20m}

# Get command line seed
seed=1 #${1:-1}

# Get the multipliers for expanding the dataset
USER_MUL=16 #${USER_MUL:-16}
ITEM_MUL=32 #${ITEM_MUL:-32}

DATASET_DIR=${BASEDIR}/${DATASET}x${USER_MUL}x${ITEM_MUL}
if ! [ -f $DATASET_DIR/alias_tbl_16x32_cached_sampler.pkl ]; then
        SCOREP_TOTAL_MEMORY=4089446400 SCOREP_ENABLE_PROFILING=true SCOREP_ENABLE_TRACING=false \
        python3.7 -m scorep ./convert.py $DATASET_DIR --seed 0
        rm -rf scorep-*/
fi

if [ -d ${DATASET_DIR} ]
then
    # start timing
    start=$(date +%s)
    start_fmt=$(date +%Y-%m-%d\ %r)
    echo "STARTING TIMING RUN AT $start_fmt"

        export PYTHONPATH="$HOME/MLPerf_training/compliance:${PYTHONPATH}"
        SCOREP_TOTAL_MEMORY=4089446400 SCOREP_ENABLE_PROFILING=true SCOREP_ENABLE_TRACING=false \
        OPENBLAS_NUM_THREADS=16 OMP_NUM_THREADS=16 \
        python3.7 -m scorep --nopython ncf.py ${DATASET_DIR} \
        -l 0.0002 \
        -b 65536 \
        --layers 256 256 128 64 \
        -f 64 \
        --seed $seed \
        --threshold $THRESHOLD \
        --user_scaling ${USER_MUL} \
        --item_scaling ${ITEM_MUL} \
        --cpu_dataloader \
        --random_negatives \
        --no-cuda \
        --epochs 1

	# end timing
	end=$(date +%s)
	end_fmt=$(date +%Y-%m-%d\ %r)
	echo "ENDING TIMING RUN AT $end_fmt"


	# report result
	result=$(( $end - $start ))
	result_name="recommendation"


	echo "RESULT,$result_name,$seed,$result,$USER,$start_fmt"
else
	echo "Directory ${DATASET_DIR} does not exist"
fi





