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

