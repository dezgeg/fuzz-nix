#!/usr/bin/env bash

rm -rf corpus
mkdir -p corpus
i=1
cat exprs-*.txt | while read -r line; do
    if [ -z "$line" ]; then continue; fi
    n=$(printf "%03d" $i)
    echo "$line" > corpus/input-$n.txt
    (( i++ ))
done

rm -rf dict
mkdir -p dict
i=1
cat lex-patterns.txt | while read -r line; do
    if [ -z "$line" ]; then continue; fi
    n=$(printf "%03d" $i)
    echo "$line" > dict/kw-$n.txt
    (( i++ ))
done

echo -e ' ' > dict/space.txt
echo -e '\t' > dict/tab.txt
echo -e '\n' > dict/nl.txt
echo -e '\r' > dict/cr.txt
echo -e '\r\n' > dict/crnl.txt
