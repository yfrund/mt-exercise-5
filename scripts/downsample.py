import argparse


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument("--input", type=str, nargs="+", help="Path to vocabulary files whose frequencies need to be removed", required=True)
    parser.add_argument("--output", type=str, nargs="+", help="Path to save clean vocabulary files", required=True)
    parser.add_argument("--num_lines", type=int, help="Number of lines to sample", required=True)

    args = parser.parse_args()

    return args
def sample(data, num_of_sents, out):
    """
    Saves a specified number of lines in a given directory
    @param data: path/to/file
    @param num_of_sents: int - number of lines to sample
    @param out: path/to/save
    """
    counter = 0
    with open(data, 'r', encoding='utf-8') as f:
        sents = f.readlines()
        with open(out, 'w', encoding='utf-8') as o:
            for sent in sents:
                if counter < num_of_sents:
                    o.write(sent)
                    counter += 1


def main():
    # sample('../data/train.nl-en.en', 100000, '../data/subsampled/train.en')
    # sample('../data/train.en-nl.nl', 100000, '../data/subsampled/train.nl')

    args = parse_args()

    for infile, outfile in zip(args.input, args.output):
        sample(infile, args.num_lines, outfile)

if __name__ == '__main__':
    main()