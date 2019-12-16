download
========
(if not installed: yum install sox)
python3.7 -m pip install wget
mkdir -p ~/data/speech_recognition; cd ~/data/speech_recognition
python3.7 ~/.../speech_recognition/data/librispeech.py
cd -

need stuff
==========
git clone https://github.com/pytorch/audio.git
cd audio/
git checkout v0.3.0
python3.7 -m scorep --nopython setup.py install
cd -
python3.7 -m pip install  python-Levenshtein
(maybe few more easy ones)

run (fix all the other stuff in the files
=========================================
./run_and_time.sh
