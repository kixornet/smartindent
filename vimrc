" needed for testing
" syntax on  " might make debugging easier
set nocompatible "to make testing setup easier
filetype indent on

source spacer.vim

function CheckSpacer()
	if &expandtab == "1"
		let c = &softtabstop
		echo "SpacerMode: ".c." spaces"
	else
		echo "SpacerMode: tabs"
	endif
endfunction

function UseTabs()
	set shiftwidth=4
	set tabstop=4
	set noexpandtab
endfunction
