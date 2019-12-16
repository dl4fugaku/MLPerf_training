get data (~14GB)
================
mkdir -p ~/data/object_detection; cd ~/data/object_detection
curl -O https://dl.fbaipublicfiles.com/detectron/coco/coco_annotations_minival.tgz
tar xzf coco_annotations_minival.tgz &
curl -O http://images.cocodataset.org/zips/train2014.zip
unzip train2014.zip &
curl -O http://images.cocodataset.org/zips/val2014.zip
unzip val2014.zip &
curl -O http://images.cocodataset.org/annotations/annotations_trainval2014.zip
unzip annotations_trainval2014.zip &
cd -

prepare
=======
python3.7 -m pip install --user matplotlib opencv-python rafiki-cocoapi Cython yacs
python3.7 -m pip install --user --upgrade Pillow==5.4.1
python3.7 -m pip install --user --upgrade torchvision==0.2.1
python3.7 -m scorep setup.py clean build develop --user
cd MLPerf_training/object_detection/pytorch
mkdir datasets
ln -s /home/domke/data/object_detection datasets/coco

run
===
SCOREP_TOTAL_MEMORY=4089446400 SCOREP_ENABLE_PROFILING=true SCOREP_ENABLE_TRACING=false \
OPENBLAS_NUM_THREADS=16 OMP_NUM_THREADS=16 \
python3.7 -m scorep --nopython tools/train_mlperf.py \
--config-file "configs/e2e_mask_rcnn_R_50_FPN_1x.yaml" SOLVER.IMS_PER_BATCH 2 TEST.IMS_PER_BATCH 1 SOLVER.MAX_ITER 100 \
SOLVER.STEPS "(480000, 640000)" SOLVER.BASE_LR 0.0025

