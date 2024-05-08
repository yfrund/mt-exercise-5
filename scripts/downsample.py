

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
    sample('../data/train.nl-en.en', 100000, '../data/subsampled/train.en')
    sample('../data/train.en-nl.nl', 100000, '../data/subsampled/train.nl')

if __name__ == '__main__':
    main()