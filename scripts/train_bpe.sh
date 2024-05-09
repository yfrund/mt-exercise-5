#! /bin/bash

scripts=$(dirname "$0")
base=$scripts/..

data=$base/data

src=nl
trg=en

subword-nmt learn-joint-bpe-and-vocab --input $data/subsampled/train.$src $data/subsampled/train.$trg --total-symbols -s 2000 -o $data/codes2000.bpe --write-vocabulary $data/vocab.$src $data/vocab.$trg
