#!/bin/bash

INPUT=output.txt
OUTPUT=dacb_10lines.txt

N=10

awk -v N=$N 'BEGIN { line = 1; } { data[line] = $0; ++line } END { for (i=0; i<N; ++i) { idx = int(rand() * line); printf("%d\n", data[idx]); } }' $INPUT > $OUTPUT
