#!/usr/bin/env bash

checksum() {
    echo -n "$@" | sha256sum | awk '{print $1}'
}

if [ "$#" -gt 0 ]; then
    exprs="$@"
else
    exprs=$(echo corpus/*.txt)
fi

mkdir -p inputs
rm -rf inputs/corpus
mkdir -p inputs/corpus

cat $exprs | while read -r line; do
    if [ -z "$line" ]; then continue; fi
    echo "$line" > inputs/corpus/initial-$(checksum "$line").in
done

rm -rf inputs/dict
mkdir -p inputs/dict

cat dict/*.txt | while read -r line; do
    if [ -z "$line" ]; then continue; fi
    echo "$line" > inputs/dict/$(checksum "$line").kw
done

echo -e ' ' > inputs/dict/space.txt
echo -e '\t' > inputs/dict/tab.txt
echo -e '\n' > inputs/dict/nl.txt
echo -e '\r' > inputs/dict/cr.txt
echo -e '\r\n' > inputs/dict/crnl.txt
