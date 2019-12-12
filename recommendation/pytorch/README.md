download and prep data
======================
mkdir -p ~/data/recommendation; cd ~/data/recommendation
curl -O http://files.grouplens.org/datasets/movielens/ml-20m.zip
curl -O http://files.grouplens.org/datasets/movielens/ml-1m.zip
unzip ml-1m.zip
echo 'userId,movieId,rating,timestamp' > ml-1m/ratings.csv
cat ml-1m/ratings.dat >> ml-1m/ratings.csv
sed -i -e 's/::/,/g' ml-1m/ratings.csv
cd -
cd ~/MLPerf_training/data_generation/fractal_graph_expansions
DATA_DIR=~/data/recommendation DATASET=ml-1m ./data_gen.sh

