" Install Vim-Plug if not previously installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    autocmd VimEnter * PlugInstall
endif

" Plugins!
call plug#begin('~/.vim/plugged')
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'dense-analysis/ale'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'tclem/vim-arduino'
Plug 'widatama/vim-phoenix'
Plug 'lervag/vimtex'
call plug#end()

" Mappings
let mapleader="'"
inoremap jk <esc>

" Map ; to : in normal and visual mode
nnoremap ; :
vnoremap ; :

inoremap <C-S> <Esc>:w<Enter>i
noremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
noremap <A-]> :vsp <CR>:exec("tag ".expand("<cword>"<CR>
map <F3> :NERDTreeToggle<CR>

function! NumberToggle()
	if(&nu==1)
		set nu!
		set rnu
	else
		set nornu
		set nu
	endif
endfunction

nnoremap <F2> :call NumberToggle()<CR>

func! WordProcessorMode()
    setlocal textwidth=0
    setlocal smartindent
    setlocal spell spelllang=en_us
    setlocal noexpandtab
    set nonu
    Goyo
endfu

let g:word_count="<unknown>"
function WordCount()
	return g:word_count
endfunction
function UpdateWordCount()
	let lnum = 1
	let n = 0
	while lnum <= line('$')
		let n = n + len(split(getline(lnum)))
		let lnum = lnum + 1
	endwhile
	let g:word_count = n
endfunction
" Update the count when cursor is idle in command or insert mode.
" Update when idle for 1000 msec (default is 4000 msec).
set updatetime=1000
augroup WordCounter
	au! CursorHold,CursorHoldI * call UpdateWordCount()
augroup END
" Set statusline, shown here a piece at a time
highlight User1 ctermbg=green guibg=green ctermfg=black guifg=black
set statusline=%1*			" Switch to User1 color highlight
set statusline+=%<%F			" file name, cut if needed at start
set statusline+=%M			" modified flag
set statusline+=%y			" file type
set statusline+=%=			" separator from left to right justified
set statusline+=\ %{WordCount()}\ words,
set statusline+=\ %l/%L\ lines,\ %P	" percentage through the file

com! Word call WordProcessorMode()

set laststatus=2
set nocompatible
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set textwidth=80
set incsearch
set ignorecase
set smartcase
set scrolloff=2
set wildmode=full
set textwidth=0
set wrapmargin=0
set showcmd
syntax enable
set t_Co=256
set viminfo='100,h,n~/.vim/viminfo'
set tags=./tags;
filetype plugin on
colors phoenix
PhoenixRed
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino
autocmd BufReadPost *.odt :%!odt2txt %

let g:vim_arduino_serial_port = "/dev/ttyACM0"
let g:vim_arduino_library_path = "/home/viperzer0/arduino-1.8.8"

" VimTex options
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'evince'

let g:vimtex_compiler_latexmk = {
    \ 'continuous ' : 1,
    \}
