#/bin/bash

RANDOM_SEED=$1
QUALITY=$2
set -e

# Register the model as a source root
export PYTHONPATH="$(pwd):$(pwd)/../../compliance:${PYTHONPATH}"
export LD_LIBRARY_PATH=/usr/local/cuda/lib64

MODEL_DIR="/tmp/resnet_imagenet_${RANDOM_SEED}"
rm -rf $MODEL_DIR

OMP_NUM_THREADS=16 TF_NUM_INTEROP_THREADS=2 TF_NUM_INTRAOP_THREADS=16 \
  python3.6 official/resnet/imagenet_main.py $RANDOM_SEED --data_dir /scr0/jens/data/imagenet/train  \
  --model_dir $MODEL_DIR --train_epochs 1 --stop_threshold $QUALITY --batch_size 128 \
  --version 1 --resnet_size 50 --epochs_between_evals 1 \
  --max_train_steps 1000 --num_gpus 1 --data_format channels_first \
  --inter_op_parallelism_threads 2 --intra_op_parallelism_threads 16
#  --model_dir $MODEL_DIR --train_epochs 10000 --stop_threshold $QUALITY --batch_size 64 \
#  --version 1 --resnet_size 50 --epochs_between_evals 4

# To run on 8xV100s, instead run:
#python3 official/resnet/imagenet_main.py $RANDOM_SEED --data_dir /imn/imagenet/combined/ \
#   --model_dir $MODEL_DIR --train_epochs 10000 --stop_threshold $QUALITY --batch_size 1024 \
#   --version 1 --resnet_size 50 --dtype fp16 --num_gpus 8 \
#   --epochs_between_evals 4
