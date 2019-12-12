downloads
=========
(none)

fixes
=====
get a bunch of files from v0.5 repo -> already integrated

more pip
========
python3.7 -m pip install argh
python3.7 -m pip install google.cloud
python3.7 -m pip install google.cloud.logging
python3.7 -m pip install google.cloud.bigtable
python3.7 -m pip install tqdm
python3.7 -m pip install sgf
python3.7 -m pip install petname
python3.7 -m pip install pygtp

run
===
GOPARAMS=params/minitest.json python3.7 -m scorep --nopython loop_init.py

SCOREP_TOTAL_MEMORY=4089446400 SCOREP_ENABLE_PROFILING=true SCOREP_ENABLE_TRACING=false \
OPENBLAS_NUM_THREADS=16 OMP_NUM_THREADS=16 TF_NUM_INTEROP_THREADS=2 TF_NUM_INTRAOP_THREADS=16 \
GOPARAMS=params/minitest.json python3.7 -m scorep --nopython loop_selfplay.py 1 0 2>&1

SCOREP_TOTAL_MEMORY=4089446400 SCOREP_ENABLE_PROFILING=true SCOREP_ENABLE_TRACING=false \
OPENBLAS_NUM_THREADS=16 OMP_NUM_THREADS=16 TF_NUM_INTEROP_THREADS=2 TF_NUM_INTRAOP_THREADS=16 \
GOPARAMS=params/minitest.json python3.7 -m scorep --nopython loop_train_eval.py 1 0 2>&1

#for tracing one should go down to 32,16,16,... in params/minitest.json
