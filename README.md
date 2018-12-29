Smart indent spacing
=====================

This script checks the first few lines of loaded files and tries to pick out the correct tab/space settings based on the file contents. If more lines start with tabs, tabs are used for indentaion. Otherwise, spaces are used for indention.

It also attempts to pick the correct number of spaces for indents. It attempts to count the number of lines with a single level of indent and the most common modulo of spaces used for indention.

Using with VIM
---------------

To use, download `spacer.vim` and put it where your .vimrc can find it (in `~/.vim/` perhaps).
Then add a line like this to your vimrc:
```
source ~/.vim/spacer.vim
```

Testing
--------

Run the `test.sh` script with bash. It will create a set of tests, then validate that indention is set correctly. It also collects timing data.
