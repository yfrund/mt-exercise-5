#! /bin/bash

scripts=$(dirname "$0")
base=$scripts/..

#modify model name
model_name=transformer_bpe1k

configs=$base/configs

python -m joeynmt test configs/$model_name.yaml