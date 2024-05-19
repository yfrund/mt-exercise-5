#! /bin/bash

scripts=$(dirname "$0")
base=$scripts/..

data=$base/data
configs=$base/configs
logs=$base/logs

translations=$base/translations

mkdir -p $translations

src=nl
trg=en


num_threads=4
device=0

# measure time

SECONDS=0

model_name=transformer_bpe1k

echo "###############################################################################"
echo "model_name $model_name"

translations_sub=$translations/$model_name

mkdir -p $translations_sub

CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt translate $configs/$model_name.yaml < $data/dev.test/test.$src > $translations_sub/test.$model_name.$trg

# compute case-sensitive BLEU 

cat $translations_sub/test.$model_name.$trg | sacrebleu $data/dev.test/test.$trg > $logs/$model_name/$model_name.bleu.txt 2>&1


echo "time taken:"
echo "$SECONDS seconds"
