#!/usr/bin/env bash

if [ "$#" -gt 0 ]; then
    exprs="$@"
else
    exprs=$(echo corpus/*.txt)
fi

mkdir -p inputs
rm -rf inputs/corpus
mkdir -p inputs/corpus

i=1
cat $exprs | while read -r line; do
    if [ -z "$line" ]; then continue; fi
    n=$(printf "%03d" $i)
    echo "$line" > inputs/corpus/initial-$n.in
    (( i++ ))
done

rm -rf inputs/dict
mkdir -p inputs/dict

i=1
cat dict/*.txt | while read -r line; do
    if [ -z "$line" ]; then continue; fi
    n=$(printf "%03d" $i)
    echo "$line" > inputs/dict/$n.kw
    (( i++ ))
done

echo -e ' ' > inputs/dict/space.txt
echo -e '\t' > inputs/dict/tab.txt
echo -e '\n' > inputs/dict/nl.txt
echo -e '\r' > inputs/dict/cr.txt
echo -e '\r\n' > inputs/dict/crnl.txt
