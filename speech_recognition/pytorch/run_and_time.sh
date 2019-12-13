# Script to train and time DeepSpeech 2 implementation

RANDOM_SEED=1
TARGET_ACC=23

if [ -d models/ ]; then rm -rf models/; fi
SCOREP_TOTAL_MEMORY=4089446400 SCOREP_ENABLE_PROFILING=true SCOREP_ENABLE_TRACING=false \
OPENBLAS_NUM_THREADS=16 OMP_NUM_THREADS=16 TF_NUM_INTEROP_THREADS=2 TF_NUM_INTRAOP_THREADS=16 \
python3.7 -m scorep --nopython train.py --model_path models/deepspeech_t$RANDOM_SEED.pth.tar --seed $RANDOM_SEED --acc $TARGET_ACC
tar cf ~/speech_recognition-pyt-dnnl-profile.tgz scorep-2*/
rm -rf scorep-*/

### trace explodes quickly, similar torch problem we had before -> skip
#if [ -d models/ ]; then rm -rf models/; fi
#SCOREP_TOTAL_MEMORY=4089446400 SCOREP_ENABLE_PROFILING=false SCOREP_ENABLE_TRACING=true \
#OPENBLAS_NUM_THREADS=16 OMP_NUM_THREADS=16 TF_NUM_INTEROP_THREADS=2 TF_NUM_INTRAOP_THREADS=16 \
#python3.7 -m scorep --nopython train.py --model_path models/deepspeech_t$RANDOM_SEED.pth.tar --seed $RANDOM_SEED --acc $TARGET_ACC
#tar cf ~/speech_recognition-pyt-dnnl-trace.tgz scorep-2*/
#rm -rf scorep-*/
#if [ -d models/ ]; then rm -rf models/; fi
