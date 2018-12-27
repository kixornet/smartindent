"based on code from
"https://unix.stackexchange.com/questions/63196/in-vim-how-can-i-automatically-determine-whether-to-use-spaces-or-tabs-for-inde#63197

" default to tabs as 4 spaces wide. 
set shiftwidth=4
set tabstop=4
"set expandtab
"set noexpandtab

" Determines whether to use spaces or tabs on the current buffer.
function SetTabsOrSpaces()
	let linesToTest = 200

	let numTabs=  len(filter(getbufline(bufname("%"), 1, linesToTest), 'v:val =~ "^\\t"'))
	let numSpaces=len(filter(getbufline(bufname("%"), 1, linesToTest), 'v:val =~ "^ "'))

	if numTabs < numSpaces
		setlocal expandtab
		setlocal smarttab

		" check for space indent up to 8
		let validWidth = [0,0,0,0,0,0,0,0,0]
		let singleArray = ["","","","","","","","",""]

		" build regex string to find lines with one spacer indent
		for testWidth in range(8,1,-1)
			let singleexpr = "^"
			for i in range(1,testWidth,1)
				let singleexpr = singleexpr." "
			endfor
			let singleexpr = singleexpr."[^ ]"
			let singleArray[testWidth] = singleexpr
			"echo singleexpr
		endfor

		let testexpr = '^ \+'
		for lineNum in range(1,linesToTest)
			let line = join(getbufline(bufname("%"), lineNum, lineNum))
			let spacesMatch = matchstr(line, testexpr)
			let spaceCount = strlen(spacesMatch)

			for testWidth in range(8,1,-1)
				" lines with single indent are key to figuring out spacing, try to count these
				let singleSpacerMatch = matchstr(line, singleArray[testWidth])
				let singleCount = strlen(singleSpacerMatch)
				let startsWithSpacer = singleCount > 0
				if startsWithSpacer
					let validWidth[testWidth] = validWidth[testWidth] + 1
				endif

				" count modulus spacers
				let countMatchesWidth = spaceCount%testWidth == 0
				let nonZeroLength = spaceCount > 0
				if countMatchesWidth && nonZeroLength
					"echo spaceCount." ".testWidth
					let validWidth[testWidth] = validWidth[testWidth] + 1
				endif

			endfor
		endfor

		" now guess based on counts
		let bestSize = 4
		let bestCount = 0
		for testWidth in range(1,8)
			if validWidth[testWidth] >= bestCount
				let bestSize = testWidth
				let bestCount = validWidth[testWidth]
			endif
		endfor
		"echo validWidth
		"echo "Bestsize: ".bestSize
		execute "set softtabstop=".bestSize
		execute "set shiftwidth=".bestSize
	endif
endfunction

" Call the function after opening a buffer
autocmd BufReadPost * call SetTabsOrSpaces()
