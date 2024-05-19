#! /bin/bash

scripts=$(dirname "$0")
base=$scripts/..

models=$base/models
configs=$base/configs
logs=$base/logs
data=$base/data
translations=$base/translations

src=nl
trg=en

mkdir -p $translations
mkdir -p $logs/translations

#adjust model name + beam sizes
model_name=transformer_bpe2k
beams=(1 2 3 4 5 6 7 8 9 10) #create an array of beam sizes

mkdir -p $translations/$model_name
mkdir -p $logs/translations/$model_name

#edit config file:
config_file=$configs/$model_name.yaml

#iterate through the beam sizes and create a translation and a log file with each
for beam_size in "${beams[@]}"; do

  python3 -c "
import yaml
with open('$config_file', 'r') as f:
  y = yaml.safe_load(f)
  y['testing']['beam_size'] = int($beam_size)

with open('$config_file', 'w') as f:
  yaml.dump(y,f)
"

  #translate, save translation in translations/model_name/file.txt
  #save log in logs/translations/model_name/file.txt
  python3 -m joeynmt translate $configs/$model_name.yaml < $data/dev.test/test.$src > $translations/$model_name/beam_$beam_size.txt 2> logs/translations/$model_name/beam_$beam_size.txt

done