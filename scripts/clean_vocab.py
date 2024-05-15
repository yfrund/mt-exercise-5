import argparse

def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument("--input", type=str, nargs="+", help="Path to vocabulary files whose frequencies need to be removed", required=True)
    parser.add_argument("--output", type=str, nargs="+", help="Path to save clean vocabulary files", required=True)

    args = parser.parse_args()

    return args

def remove_frequencies(infile, out):
    with open(infile, 'r', encoding='utf-8') as i:
        lines = i.readlines()
        with open(out, 'w', encoding='utf-8') as o:
            for line in lines:
                o.write(line.split()[0]+'\n')

def main():
    args = parse_args()

    for infile, outfile in zip(args.input, args.output):
        remove_frequencies(infile, outfile)

if __name__ == '__main__':
    main()