
def remove_frequencies(infile, out):
    with open(infile, 'r', encoding='utf-8') as i:
        lines = i.readlines()
        with open(out, 'w', encoding='utf-8') as o:
            for line in lines:
                o.write(line.split()[0]+'\n')

def main():
    remove_frequencies('../data/joint_vocab2k.txt', '../data/joint_vocab2k_clean.txt')
    remove_frequencies('../data/joint_vocab4k.txt', '../data/joint_vocab4k_clean.txt')

if __name__ == '__main__':
    main()