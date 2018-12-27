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


#run spacer validation
vim -n -e -s -u vimrc +'verbose call CheckSpacer()' +'quit' temp.space1 2>> temp.indent_test
vim -n -e -s -u vimrc +'verbose call CheckSpacer()' +'quit' temp.space2 2>> temp.indent_test
vim -n -e -s -u vimrc +'verbose call CheckSpacer()' +'quit' temp.space3 2>> temp.indent_test
vim -n -e -s -u vimrc +'verbose call CheckSpacer()' +'quit' temp.space4 2>> temp.indent_test
vim -n -e -s -u vimrc +'verbose call CheckSpacer()' +'quit' temp.space5 2>> temp.indent_test
vim -n -e -s -u vimrc +'verbose call CheckSpacer()' +'quit' temp.space6 2>> temp.indent_test
vim -n -e -s -u vimrc +'verbose call CheckSpacer()' +'quit' temp.space7 2>> temp.indent_test
vim -n -e -s -u vimrc +'verbose call CheckSpacer()' +'quit' temp.space8 2>> temp.indent_test
vim -n -e -s -u vimrc +'verbose call CheckSpacer()' +'quit' temp.tab    2>> temp.indent_test
vim -n -e -s -u vimrc +'verbose call CheckSpacer()' +'quit' temp.large  2>> temp.indent_test
vim -n -e -s -u vimrc +'verbose call CheckSpacer()' +'quit' temp.large_very 2>> temp.indent_test

printf "\r
SpacerMode: 1 spaces\r
SpacerMode: 2 spaces\r
SpacerMode: 3 spaces\r
SpacerMode: 4 spaces\r
SpacerMode: 5 spaces\r
SpacerMode: 6 spaces\r
SpacerMode: 7 spaces\r
SpacerMode: 8 spaces\r
SpacerMode: tabs\r
SpacerMode: 7 spaces\r
SpacerMode: 7 spaces" > temp.indent_goal

diff temp.indent_goal temp.indent_test > /dev/null

if [ $? -ne 0 ] ; then
	echo "FAILURE: incorrect spacer mode setting. Goal | Result:"
	diff --suppress-common-lines -y -W 60  temp.indent_goal temp.indent_test
fi

rm temp.indent*

#run timing test
rm temp.timings
for f in `ls temp.*`
do
	echo "${f}" >> temp.timings
	time -p vim -n -u vimrc +'quit' "${f}" 2>> temp.timings
done
