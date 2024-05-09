#! /bin/bash

scripts=$(dirname "$0")
base=$scripts/..

data=$base/data

src=nl
trg=en

#train with 2k vocabulary
subword-nmt learn-joint-bpe-and-vocab --input $data/subsampled/train.$src $data/subsampled/train.$trg --total-symbols -s 2000 -o $data/codes2000.bpe --write-vocabulary $data/vocab2k.$src $data/vocab2k.$trg
cat $data/vocab2k.$src $data/vocab2k.$trg > $data/joint_vocab2k.txt

subword-nmt apply-bpe -c $data/codes2000.bpe --vocabulary $data/vocab2k.$src --vocabulary-threshold 2000 < $data/subsampled/train.$src > $data/subsampled/train.2k.BPE.$src
subword-nmt apply-bpe -c $data/codes2000.bpe --vocabulary $data/vocab2k.$trg --vocabulary-threshold 2000 < $data/subsampled/train.$trg > $data/subsampled/train.2k.BPE.$trg

#train with 4k vocabulary
subword-nmt learn-joint-bpe-and-vocab --input $data/subsampled/train.$src $data/subsampled/train.$trg --total-symbols -s 4000 -o $data/codes4000.bpe --write-vocabulary $data/vocab4k.$src $data/vocab4k.$trg
cat $data/vocab4k.$src $data/vocab4k.$trg > $data/joint_vocab4k.txt

subword-nmt apply-bpe -c $data/codes4000.bpe --vocabulary $data/vocab4k.$src --vocabulary-threshold 4000 < $data/subsampled/train.$src > $data/subsampled/train.4k.BPE.$src
subword-nmt apply-bpe -c $data/codes4000.bpe --vocabulary $data/vocab4k.$trg --vocabulary-threshold 4000 < $data/subsampled/train.$trg > $data/subsampled/train.4k.BPE.$trg

#extract
python3 ../joeynmt/scripts/build_vocab.py configs/transformer_bpe2k.yaml --joint
python3 ../joeynmt/scripts/build_vocab.py configs/transformer_bpe4k.yaml --joint

#test/dev data
subword-nmt apply-bpe -c $data/codes2000.bpe --vocabulary $data/vocab2k.$src --vocabulary-threshold 2000 < $data/dev.test/test.$src > $data/dev.test/test.2k.BPE.$src
subword-nmt apply-bpe -c $data/codes2000.bpe --vocabulary $data/vocab2k.$trg --vocabulary-threshold 2000 < $data/dev.test/test.$trg > $data/dev.test/test.2k.BPE.$trg

subword-nmt apply-bpe -c $data/codes2000.bpe --vocabulary $data/vocab2k.$src --vocabulary-threshold 2000 < $data/dev.test/dev.$src > $data/dev.test/dev.2k.BPE.$src
subword-nmt apply-bpe -c $data/codes2000.bpe --vocabulary $data/vocab2k.$trg --vocabulary-threshold 2000 < $data/dev.test/dev.$trg > $data/dev.test/dev.2k.BPE.$trg

subword-nmt apply-bpe -c $data/codes4000.bpe --vocabulary $data/vocab4k.$src --vocabulary-threshold 4000 < $data/dev.test/test.$src > $data/dev.test/test.4k.BPE.$src
subword-nmt apply-bpe -c $data/codes4000.bpe --vocabulary $data/vocab4k.$trg --vocabulary-threshold 4000 < $data/dev.test/test.$trg > $data/dev.test/test.4k.BPE.$trg

subword-nmt apply-bpe -c $data/codes4000.bpe --vocabulary $data/vocab4k.$src --vocabulary-threshold 4000 < $data/dev.test/dev.$src > $data/dev.test/dev.4k.BPE.$src
subword-nmt apply-bpe -c $data/codes4000.bpe --vocabulary $data/vocab4k.$trg --vocabulary-threshold 4000 < $data/dev.test/dev.$trg > $data/dev.test/dev.4k.BPE.$trg