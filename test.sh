#!/bin/bash

cp vimrc temp.tab
cp vimrc temp.space1
cp vimrc temp.space2
cp vimrc temp.space3
cp vimrc temp.space4
cp vimrc temp.space5
cp vimrc temp.space6
cp vimrc temp.space7
cp vimrc temp.space8

vim -n -e -s -u vimrc +'%s/\t/ /g' +'wq' temp.space1
vim -n -e -s -u vimrc +'%s/\t/  /g' +'wq' temp.space2
vim -n -e -s -u vimrc +'%s/\t/   /g' +'wq' temp.space3
vim -n -e -s -u vimrc +'%s/\t/    /g' +'wq' temp.space4
vim -n -e -s -u vimrc +'%s/\t/     /g' +'wq' temp.space5
vim -n -e -s -u vimrc +'%s/\t/      /g' +'wq' temp.space6
vim -n -e -s -u vimrc +'%s/\t/       /g' +'wq' temp.space7
vim -n -e -s -u vimrc +'%s/\t/        /g' +'wq' temp.space8

cat temp.space7 temp.space7 temp.space7 temp.space7 temp.space7 temp.space7 temp.space7 temp.space7 temp.space7 temp.space7 temp.space7 temp.space7 temp.space7 temp.space7 temp.space7 temp.space7 > temp.large
cat temp.large temp.large temp.large temp.large temp.large temp.large temp.large temp.large temp.large temp.large temp.large temp.large temp.large temp.large temp.large temp.large > temp.large_very

for f in `ls temp.*`
do
	echo "${f}"
	time -p vim -n -S exit.vim -u vimrc "${f}"
done
