#! /bin/bash

scripts=$(dirname "$0")
base=$scripts/..

data=$base/data

src=nl
trg=en

#train with 2k vocabulary
#the number of input files must match the number of vocabulary files, so I'm extracting two vocabulary files here,
#and then concatenating them to create a joint vocabulary
#subword-nmt learn-joint-bpe-and-vocab --input $data/subsampled/train.$src $data/subsampled/train.$trg --total-symbols -s 2000 -o $data/codes2000.bpe --write-vocabulary $data/vocab2k.$src $data/vocab2k.$trg
#cat $data/vocab2k.$src >> $data/joint_vocab2k.txt
#cat $data/vocab2k.$trg >> $data/joint_vocab2k.txt
#
#subword-nmt apply-bpe -c $data/codes2000.bpe --vocabulary $data/vocab2k.$src --vocabulary-threshold 2000 < $data/subsampled/train.$src > $data/subsampled/train.2k.BPE.$src
#subword-nmt apply-bpe -c $data/codes2000.bpe --vocabulary $data/vocab2k.$trg --vocabulary-threshold 2000 < $data/subsampled/train.$trg > $data/subsampled/train.2k.BPE.$trg

#train with 1k vocabulary
subword-nmt learn-joint-bpe-and-vocab --input $data/subsampled/train.$src $data/subsampled/train.$trg --total-symbols -s 1000 -o $data/codes1000.bpe --write-vocabulary $data/vocab1k.$src $data/vocab1k.$trg
cat $data/vocab1k.$src >> $data/joint_vocab1k.txt
cat $data/vocab1k.$trg >> $data/joint_vocab1k.txt

subword-nmt apply-bpe -c $data/codes1000.bpe --vocabulary $data/vocab1k.$src --vocabulary-threshold 1000 < $data/subsampled/train.$src > $data/subsampled/train.1k.BPE.$src
subword-nmt apply-bpe -c $data/codes1000.bpe --vocabulary $data/vocab1k.$trg --vocabulary-threshold 1000 < $data/subsampled/train.$trg > $data/subsampled/train.1k.BPE.$trg

##test/dev data
#subword-nmt apply-bpe -c $data/codes2000.bpe --vocabulary $data/vocab2k.$src --vocabulary-threshold 2000 < $data/dev.test/test.$src > $data/dev.test/test.2k.BPE.$src
#subword-nmt apply-bpe -c $data/codes2000.bpe --vocabulary $data/vocab2k.$trg --vocabulary-threshold 2000 < $data/dev.test/test.$trg > $data/dev.test/test.2k.BPE.$trg
#
#subword-nmt apply-bpe -c $data/codes2000.bpe --vocabulary $data/vocab2k.$src --vocabulary-threshold 2000 < $data/dev.test/dev.$src > $data/dev.test/dev.2k.BPE.$src
#subword-nmt apply-bpe -c $data/codes2000.bpe --vocabulary $data/vocab2k.$trg --vocabulary-threshold 2000 < $data/dev.test/dev.$trg > $data/dev.test/dev.2k.BPE.$trg

subword-nmt apply-bpe -c $data/codes1000.bpe --vocabulary $data/vocab1k.$src --vocabulary-threshold 1000 < $data/dev.test/test.$src > $data/dev.test/test.1k.BPE.$src
subword-nmt apply-bpe -c $data/codes1000.bpe --vocabulary $data/vocab1k.$trg --vocabulary-threshold 1000 < $data/dev.test/test.$trg > $data/dev.test/test.1k.BPE.$trg

subword-nmt apply-bpe -c $data/codes1000.bpe --vocabulary $data/vocab1k.$src --vocabulary-threshold 1000 < $data/dev.test/dev.$src > $data/dev.test/dev.1k.BPE.$src
subword-nmt apply-bpe -c $data/codes1000.bpe --vocabulary $data/vocab1k.$trg --vocabulary-threshold 1000 < $data/dev.test/dev.$trg > $data/dev.test/dev.1k.BPE.$trg

python3 scripts/clean_vocab.py --input $data/joint_vocab2k.txt $data/joint_vocab1k.txt --output $data/joint_vocab1k_clean.txt $data/joint_vocab1k_clean.txt