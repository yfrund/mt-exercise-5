import argparse
import json
from pathlib import Path
import re

from matplotlib import pyplot as plt

def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument("--input", type=str, help="Folder with log files that contain bleu scores", required=True)
    parser.add_argument("--output", type=str, help="Folder to save plot", required=True)

    args = parser.parse_args()

    return args

def line_chart(x_vals: list, y_vals: list, x_label: str, y_label: str, name: str, output):

    plt.figure(figsize=(8,6))
    plt.plot(x_vals, y_vals, label=name, linestyle='-')

    plt.title(name.title())
    plt.xlabel(x_label.title())
    plt.ylabel(y_label.title())
    plt.legend()
    plt.xticks(x_vals, x_vals)
    plt.yticks(plt.yticks()[0], plt.yticks()[0])

    plt.grid(axis='y')

    plt.savefig(output+'/'+name+'.png')
    plt.clf()

def barplot(x_vals: list, y_vals: list, x_label: str, y_label: str, name: str, output):
    plt.figure(figsize=(8, 10))

    plt.bar(x_vals, y_vals, color='g')

    plt.title(name.title())
    plt.xlabel(x_label.title())
    plt.ylabel(y_label.title())


    min_y = min(y_vals) - 1
    max_y = max(y_vals) + 0.25

    plt.ylim(min_y, max_y)
    plt.yticks(y_vals)

    plt.xticks(x_vals, x_vals)
    plt.grid(True)

    plt.savefig(output + '/' + name + '.png')
    plt.clf()

def get_bleu(log_file):
    with open(log_file, 'r', encoding='utf-8') as f:
        infile = json.load(f)
        return infile['score']

def get_time(log_file):
    with open(log_file, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        time = re.search(r"Generation took ([\d\.]+)\[sec\]", lines[-1]).group(1)
        return time

def main():

    args = parse_args()

    bleus = []
    times = []

    bleu_logs = Path(args.input).glob('bleu*')
    time_logs = Path(args.input).glob('beam*')

    for file in bleu_logs:
        bleu = get_bleu(file)
        bleus.append((file.stem.split('.')[1], bleu))

    bleus = sorted(bleus, key=lambda x: int(x[0]))
    x_vals = [int(x[0]) for x in bleus]
    y_vals = [float(x[1]) for x in bleus]

    barplot(x_vals, y_vals, 'beam size', 'BLEU score', 'Beam size VS BLEU score', args.output)

    for file in time_logs:
        time = get_time(file)
        times.append((file.stem.split('_')[1], time))

    times = sorted(times, key=lambda x: int(x[0]))
    x_vals2 = [int(x[0]) for x in times]
    y_vals2 = [float(x[1]) for x in times]

    line_chart(x_vals2, y_vals2, 'beam size', 'time taken (seconds)', 'beam size VS time taken', args.output)


if __name__=='__main__':
    main()