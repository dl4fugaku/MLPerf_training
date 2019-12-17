download (~20GB)
================
mkdir ~/data/sentiment_analysis
python3.7 -m scorep --nopython ~/MLPerf_training/sentiment_analysis/download.py

files
=====
cat Paddle/dnnl.filter
```
SCOREP_FILE_NAMES_BEGIN
        EXCLUDE *
	INCLUDE */mkldnn/*
		*/mkl-dnn/*
		*/mkl_dnn/*
		*/mkldnn.dir/*
		*/mkldnn_shared_lib.dir/*
		*/MKLDNN/*
		*/MKL-DNN/*
		*/MKL_DNN/*
SCOREP_FILE_NAMES_END
```
cat Paddle/gcc
```
#!/bin/bash
/home/domke/spack/opt/spack/linux-centos7-skylake_avx512/gcc-9.2.0/scorep-6.0-sbkteibznvke2ljpdrxiy7sw77mitoaa/bin/scorep --thread=pthread --nopomp --noopenmp --instrument-filter=/home/domke/Paddle/dnnl.filter /home/domke/spack/opt/spack/linux-centos7-skylake_avx512/gcc-9.2.0/gcc-9.1.0-44udnocvrz5hbajwyguczp7hdubw3n7y/bin/gcc $@
```
cat Paddle/g++
```
#!/bin/bash
/home/domke/spack/opt/spack/linux-centos7-skylake_avx512/gcc-9.2.0/scorep-6.0-sbkteibznvke2ljpdrxiy7sw77mitoaa/bin/scorep --thread=pthread --nopomp --noopenmp --instrument-filter=/home/domke/Paddle/dnnl.filter /home/domke/spack/opt/spack/linux-centos7-skylake_avx512/gcc-9.2.0/gcc-9.1.0-44udnocvrz5hbajwyguczp7hdubw3n7y/bin/g++ $@
```

build paddle (w dnnl but w/o mkl)
=================================
ulimit -n 4096
. $HOME/spack/share/spack/setup-env.sh
for x in `spack find | /usr/bin/grep 'gcc@9.2.0 ----' -A100 | /usr/bin/grep autoconf -A100`; do spack load ${x}%gcc@9.2.0; done
# https://www.paddlepaddle.org.cn/documentation/docs/en/1.6/beginners_guide/install/compile/compile_CentOS_en.html
cd $HOME
git clone https://github.com/PaddlePaddle/Paddle.git
cd ~/Paddle
git checkout -b v1.6.2 v1.6.2
mkdir build; cd build
SCOREP_WRAPPER=off CC=$HOME/Paddle/gcc CXX=$HOME/Paddle/g++ \
	cmake ../ -DPY_VERSION=3.7 -DWITH_FLUID_ONLY=ON -DWITH_GPU=OFF -DWITH_AVX=ON -DWITH_MKL=OFF -DWITH_SYSTEM_BLAS=ON \
	-DWITH_DISTRIBUTE=OFF -DWITH_XBYAK=ON -DWITH_MKLML=OFF -DWITH_MKLDNN=ON -DWITH_TESTING=OFF -DCMAKE_BUILD_TYPE=RelWithDebInfo \
	-DOPENBLAS_ROOT=/home/domke/spack/opt/spack/linux-centos7-skylake_avx512/gcc-9.2.0/openblas-0.3.6-xidp266ceuih6axf2sn2o3ke4cjnmzlw
make -j64
python3.7 -m pip install --user --upgrade python/dist/paddlepaddle-1.6.2-cp37-cp37m-linux_x86_64.whl

run
===
mkdir -p $HOME/.cache/paddle/dataset/imdb
ln -s $HOME/data/sentiment_analysis/aclImdb_v1.tar.gz $HOME/.cache/paddle/dataset/imdb/imdb%2FaclImdb_v1.tar.gz
SCOREP_TOTAL_MEMORY=4089446400 SCOREP_ENABLE_PROFILING=true SCOREP_ENABLE_TRACING=false \
	OPENBLAS_NUM_THREADS=32 OMP_NUM_THREADS=32 python3.7 -m scorep --nopython ./train.py -s 1
