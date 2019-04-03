#! /usr/bin/env bash
for f in ./json/*.json; do
  ./json2csv $f;
done
