# MT Exercise 5: Byte Pair Encoding, Beam Search
This repository is a starting point for the 5th and final exercise. As before, fork this repo to your own account and the clone it into your prefered directory.

## Requirements

- This only works on a Unix-like system, with bash available.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

## Steps

Clone your fork of this repository in the desired place:

    git clone https://github.com/[your-name]/mt-exercise-5

Create a new virtualenv that uses Python 3.10. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software as described in the exercise pdf.

Download data:

    ./download_iwslt_2017_data.sh
    
Before executing any further steps, you need to make the modifications described in the exercise pdf.

Downsample data:

    ./scripts/downsample.py --input path/to/input/file --num_lines number_of_lines_to_keep --output path/to/save/downsampled/data


Train a model:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

To continue training modify the configuration file:

	- load_model: "path/to/checkpoint"

	- src_vocab: "path/to/source/vocabulary"

	- trg_vocab: "path/to/target/vocabulary"

Remember to also adjust the number of epochs!

Remove frequencies in vocabulary files produced after training a BPE model:

    ./scripts/clean_vocab.py --input path/to/file/with/frequencies --output path/to/save/vocabulary

Evaluate a trained model with

    ./scripts/evaluate.sh

Create translations and log files with varying beam sizes:

    ./scripts/translate.sh

The script iterates through a list of beam sizes and produces a translation and a log file for each beam size. Translations are saved in translations/model_name, log files - in logs/translations/model_name.

Evaluate translations produced with different beam sizes:

    ./scripts/eval_beam_sizes.sh

The script iterates through a list of translation files and saves the output in logs/translations/model_name/file.txt

Visualize the relationship between beam size and BLEU score and beam size and the time it takes to generate translations:

    python3 visualize.py --input path/to/folder --output path/to/folder

Input is the folder with log files produced by translate.sh and eval_beam_sizes.sh. 