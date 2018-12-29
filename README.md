Smart indent spacing
----------------------------

This script checks the first few lines of loaded files and tries to pick out the correct tab/space settings based on the file contents.

Using with VIM
===============

To use, download `spacer.vim` and put it in the same directory as your vimrc.
Then add this line to your vimrc:
```
source spacer.vim
```

Testing
=======

Run the `test.sh` script with bash. It will create a set of tests, then validate that indention is set correctly. It also collects timing data.
