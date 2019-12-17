get data (~20GB)
================
mkdir -p ~/data/single_stage_detector; cd ~/data/single_stage_detector
curl -O http://images.cocodataset.org/zips/train2017.zip
unzip train2017.zip &
curl -O http://images.cocodataset.org/zips/val2017.zip
unzip val2017.zip &
curl -O http://images.cocodataset.org/annotations/annotations_trainval2017.zip
unzip annotations_trainval2017.zip &
cd -

running
=======
SCOREP_TOTAL_MEMORY=4089446400 SCOREP_ENABLE_PROFILING=true SCOREP_ENABLE_TRACING=false \
OPENBLAS_NUM_THREADS=16 OMP_NUM_THREADS=16 \
python3.7 -m scorep --nopython ./train.py --epochs 1 --warmup-factor 0 --lr 2.5e-3 \
--no-save --threshold=0.23 --data $HOME/data/single_stage_detector --no-cuda

