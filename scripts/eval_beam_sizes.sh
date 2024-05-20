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

model_name=transformer_bpe2k

echo "###############################################################################"
echo "model_name $model_name"

translations_sub=$translations/$model_name
beam_sizes=(1 2 3 4 5 6 7 8 9 10)

for beam_size in "${beam_sizes[@]}"; do
  file_name="beam_${beam_size}.txt"
  file_path=$translations_sub/$file_name

  if [ -f "$file_path" ]; then
    echo "Processing: $file_name"

    cat $translations_sub/$file_name | sacrebleu $data/dev.test/test.$trg > $logs/translations/$model_name/bleu.$beam_size.txt 2>&1

  else
    echo "File not found: $file_path"
  fi
done
