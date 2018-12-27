#!/bin/bash

for f in `ls *.c`
do
	echo "${f}"
	time -p vim -S exit.vim -u vimrc "${f}"
done
