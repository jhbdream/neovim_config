" Do not use smart case in command line mode, extracted from https://vi.stackexchange.com/a/16511/15292.
augroup dynamic_smartcase
	autocmd!
	autocmd CmdLineEnter : set nosmartcase
	autocmd CmdLineLeave : set smartcase
augroup END

augroup term_settings
	autocmd!
	" Do not use number and relative number for terminal inside nvim
	autocmd TermOpen * setlocal norelativenumber nonumber
	" Go to insert mode by default to start typing command
	autocmd TermOpen * startinsert
augroup END

" Return to last cursor position when opening a file
augroup resume_cursor_position
	autocmd!
	autocmd BufReadPost * call s:resume_cursor_position()
augroup END

" Only resume last cursor position when there is no go-to-line command (something like '+23').
function s:resume_cursor_position() abort
	if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
		let l:args = v:argv  " command line arguments
		for l:cur_arg in l:args
			" Check if a go-to-line command is given.
			let idx = match(l:cur_arg, '\v^\+(\d){1,}$')
			if idx != -1
				return
			endif
		endfor

		execute "normal! g`\"zvzz"
	endif
endfunction

augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" Load auto-command defined in Lua
lua require("custom-autocmd")
