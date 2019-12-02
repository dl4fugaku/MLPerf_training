download (~6GB)
===============
mkdir ~/data/translation; cd ~/data/translation
wget https://storage.googleapis.com/tf-perf-public/official_transformer/test_data/newstest2014.tgz
tar xzf newstest2014.tgz
python3 ~/MLPerf_training/translation/data_download.py --raw_dir raw_data
cd -


