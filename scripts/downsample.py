

def sample(data, num_of_sents, out):

    counter = 0
    with open(data, 'r', encoding='utf-8') as f:
        sents = f.readlines()
        with open(out, 'w', encoding='utf-8') as o:
            for sent in sents:
                if counter < num_of_sents:
                    o.write(sent)
                    counter += 1


def main():
    sample('../data/train.nl-en.en', 100000, '../data/subsampled/train.nl-en-en')
    sample('../data/train.en-nl.nl', 100000, '../data/subsampled/trainen-nl.nl')

if __name__ == '__main__':
    main()