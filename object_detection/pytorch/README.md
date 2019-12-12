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


