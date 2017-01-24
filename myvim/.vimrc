"Basic settings------{{{

"Enable filetype plugin
filetype plugin on
filetype indent on

"1 tab = 4 spaces
set shiftwidth=4
set tabstop=4
"Be smart when using tabs
"set smarttab
set expandtab

" enable backspace
set backspace=indent,eol,start

set number
filetype on
syntax on
set incsearch
set hlsearch
colorscheme grb256
if has("gui_running")
    if has("gui_gtk2")
        set guifont=Monaco\ 11
    elseif has("gui_photon")
        set guifont=Monaco:s11
    else
        set guifont=Monaco:h19
    endif
endif
set cursorline
"}}}
"Mappings-----------{{{
"Uppercase the current word
"inoremap <c-u> <esc>vUa
"nnoremap <c-u> vU
"Lowercase the current word
inoremap <c-l> <esc>vua
nnoremap <c-l> vu
"delete current line in insert mode
inoremap <c-d> <esc>ddi

"automatically insert \v whenever search
nnoremap / /\v

"Leader
let mapleader = ","
"highlight trailing whitespace as an error
nnoremap <leader>w :match Error / $/<cr>
nnoremap <leader>W :match none<cr>

nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" navigvation
nnoremap gl g$
"Move to beginning or ending of the word
nnoremap <leader>h ^
nnoremap <leader>l $
inoremap <leader>h <esc>^i
inoremap <leader>l <esc>$a

" YCM
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

"exit insert mode
inoremap jk <esc>
inoremap <nop> <esc>

"move between tabs
nnoremap <leader>t] :tabnext<cr>
nnoremap <leader>t[ :tabprevious<cr>
nnoremap <leader>tf :tabfirst<cr>
nnoremap <leader>tl :tablast<cr>


nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
noremap <leader>p vi(
noremap <leader>cb vi{

"copy from clipboard
nnoremap <c-v> "+p
"copy to clipboard
vnoremap <c-c> "+y
nnoremap <c-z> :redo<cr>

nnoremap <c-t> :NERDTreeToggle<cr>
nnoremap <c-s> :TagbarToggle<cr>

"
nnoremap <leader>rp :execute "!python "."'".expand("%:p")."'"<cr>
"}}}

" autocmd --------{{{
autocmd BufNewFile *.py call AddAuthorInfo()
" ------}}}

" customized function -------{{{
function! AddAuthorInfo()
    call append(0,'#!/usr/bin/python')
    call append(1, '#-*-coding:utf-8 -*-')
    call append(2, '#Author   : Zodiac')
    call append(3, '#Version  : 1.0')
    call append(4, '#Filename : '.expand("%:t"))
endfunction
" -------}}}

"abbreviations{{{
iabbrev adn and
iabbrev waht what
iabbrev tehn then
iabbrev taht that
"}}}

"operator-pending mappings{{{
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>
"}}}

"author and email
iabbrev ssig "author:Zodiac email:eminemhe@163.com

"Vimscript file settings-----------{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}
"Vundle settings----{{{
"For vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
"vim-scripts repos
Bundle 'bash-support.vim'
Bundle 'perl-support.vim'
"Bundle 'Shougo/neocomplcache.git'
"Bundle 'Shougo/neosnippet.git'
Bundle 'Valloric/YouCompleteMe'
Bundle 'rdnetto/YCM-Generator'
Bundle 'scrooloose/nerdtree'
Bundle 'matrix.vim--Yang'
Bundle 'Pydiction'
Bundle 'pythoncomplete'
Bundle 'xml.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Tagbar'
Bundle 'pyflakes/pyflakes-vim'
Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'
Bundle 'JamshedVesuna/vim-markdown-preview'
filetype plugin indent on
"}}}
"Pydiction{{{
"pydiction 1.2 python auto complete
"filetype plugin on
let g:pydiction_location = $HOME.'/.vim/bundle/Pydiction/complete-dict'
"default g:pydiction_menu_height == 15
"let g:pydiction_menu_height = 20
"}}}
"Poweline-----{{{
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let t_Co=256
"set nocompatible
set laststatus=2
set encoding=utf-8
let g:Powerline_symbols = 'fancy'
set fillchars+=stl:\ ,stlnc:\
"}}}
"Toggling-------{{{
"foldcolumn
nnoremap <leader>f :call FoldColumnToggle()<cr>

function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
	setlocal foldcolumn=4
    endif
endfunction

"toggle quickfix
nnoremap <leader>q :call QuickfixToggle()<cr>

let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
	let g:quickfix_is_open = 0
	execute g:quickfix_return_to_window . "wincmd w"
    else
	let g:quickfix_return_to_window = winnr()
	copen
	let g:quickfix_is_open = 1
    endif
endfunction

"Toggle Menu and Toobar
set guioptions-=m
set guioptions-=T
map <silent><F2> :call ToggleMenuBar()<cr>

function! ToggleMenuBar()
	if &guioptions =~# 'T' 
		set guioptions-=T
		set guioptions-=m
	else
 		set guioptions+=T
		set guioptions+=m
	endif
endfunction
"}}}
"Python_Folding---{{{
if exists("b:did_ftplugin")
finish
endif
let b:did_ftplugin = 1

map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
map <buffer> gd /def <C-R><C-W><CR> 

set foldmethod=expr
set foldexpr=PythonFoldExpr(v:lnum)
set foldtext=PythonFoldText()

map <buffer> f za
map <buffer> F :call ToggleFold()<CR>
let b:folded = 1

function! ToggleFold()
    if( b:folded == 0 )
        exec "normal! zM"
        let b:folded = 1
    else
        exec "normal! zR"
        let b:folded = 0
    endif
endfunction

function! PythonFoldText()
    let size = 1 + v:foldend - v:foldstart
    if size < 10
        let size = " " . size
    endif
    if size < 100
        let size = " " . size
    endif
    if size < 1000
        let size = " " . size
    endif
    
    if match(getline(v:foldstart), '"""') >= 0
        let text = substitute(getline(v:foldstart), '"""', '', 'g' ) . ' '
    elseif match(getline(v:foldstart), "'''") >= 0
        let text = substitute(getline(v:foldstart), "'''", '', 'g' ) . ' '
    else
        let text = getline(v:foldstart)
    endif
    
    return size . ' lines:'. text . ' '
endfunction

function! PythonFoldExpr(lnum)
    if indent( nextnonblank(a:lnum) ) == 0
        return 0
    endif
    
    if getline(a:lnum-1) =~ '^\(class\|def\)\s'
        return 1
    endif
        
    if getline(a:lnum) =~ '^\s*$'
        return "="
    endif
    
    if indent(a:lnum) == 0
        return 0
    endif

    return '='
endfunction

" In case folding breaks down
function! ReFold()
    set foldmethod=expr
    set foldexpr=0
    set foldnestmax=1
    set foldmethod=expr
    set foldexpr=PythonFoldExpr(v:lnum)
    set foldtext=PythonFoldText()
    echo 
endfunction
"}}}
"Markdown Previw----{{{
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=2
"----}}}
