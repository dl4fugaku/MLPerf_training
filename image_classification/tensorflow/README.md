setup
=====
python3.7 -m pip install -r requirements.txt
sed -i -e 's/import tensorflow as tf/import tensorflow as tf/' /scr0/jens/spack/opt/spack/linux-centos7-x86_64/gcc-9.1.0/python-3.7.3-civ2iiqopzfrzuhnit4hpexjlm4uwp5b/lib/python3.7/site-packages/mlperf_compliance/tf_mlperf_log.py

get imagenet downloader
=======================
wget https://raw.githubusercontent.com/tensorflow/tpu/master/tools/datasets/imagenet_to_gcs.py
(ignore; pushed into git)

mod to use locale tar dump
==========================
(ignore; pushed into git)

pre-process images
==================
cd <root>/image_classification/tensorflow
python3.7 ./imagenet_to_gcs.py --local_scratch_dir=/scr0/jens/data/imagenet --nogcs_upload
cp /scr0/jens/data/imagenet/validation/* /scr0/jens/data/imagenet/train/

usage info (python3.6 official/resnet/imagenet_main.py 1 -h)
============================================================
usage: imagenet_main.py [-h] [--data_dir <DD>] [--model_dir <MD>]
                        [--train_epochs <TE>] [--epochs_between_evals <EBE>]
                        [--stop_threshold <ST>] [--batch_size <BS>]
                        [--enable_lars] [--label_smoothing <LSM>]
                        [--weight_decay <WD>] [--fine_tune] [--num_gpus <NG>]
                        [--hooks <HK> [<HK> ...]]
                        [--inter_op_parallelism_threads <INTER>]
                        [--intra_op_parallelism_threads <INTRA>]
                        [--use_synthetic_data] [--max_train_steps <MTS>]
                        [--dtype <DT>] [--loss_scale LOSS_SCALE]
                        [--data_format <CF>] [--export_dir <ED>]
                        [--benchmark_log_dir <BLD>] [--gcp_project <GP>]
                        [--bigquery_data_set <BDS>]
                        [--bigquery_run_table <BRT>]
                        [--bigquery_metric_table <BMT>] [--version {1,2}]
                        [--resnet_size {18,34,50,101,152,200}]

fix problems with TF 2.0.0
==========================
(ignore; pushed into git)

fix mlperf_compliance
=====================
(ignore; pushed into git)

finally run it (modded to run 1k steps and 1 epoch only)
========================================================
time ./run_and_time.sh

