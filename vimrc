" About: Vim configuration file
" Author: Tom Daniels
"
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'
" github repos
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
" vim-scripts repos
Bundle 'cocoa.vim'
Bundle 'Tagbar'
Bundle 'snipMate'
Bundle 'LaTeX-Suite-aka-Vim-LaTeX'
Bundle 'cscope.vim'
Bundle 'Tag-Signature-Balloons'
Bundle 'Wombat'

set cc=+1

" don't beep at me
set vb t_vb=

" set the textwidth
set textwidth=80

" This is the default comments string setting, with - added so it can be used 
" in bulletted lists.
set comments=s1:/*,mb:*,ex:*/,://,b:#,b:-,b:+,:%,fb:-,:\\item

" auto-format shizz
set formatoptions=nrtq 

" Set the colorscheme
" set background=light
" colorscheme desert
" colorscheme solarized
colorscheme wombat

" set tags=tags such that the file in CWD is always used
set tags=tags

" key bind popular cmds
map <F8> :w<CR> :!make<CR>
map <F2> :set number!<CR> :set foldcolumn=0<CR>
map <F3> :w<CR> :!make view<CR>
map <F4> :NERDTreeToggle<CR>
map ** gwap

" latex specific bindings
map tt i{\tt <Esc>wea}<Esc>

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead
set ignorecase
set history=20		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" set the status line to display some useful info and set laststatus=2 so it always displays.
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

if has('gui_running')
    set ballooneval
    set balloondelay=100
    set guifont=Inconsolata:h14
endif

" turn on line current line highlighting for easier viewing
" set cursorline
" hi CursorLine    ctermfg=White ctermbg=Black cterm=none

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" tagbar options
map <F10> :TagbarToggle<CR>   	       	       " open the tagbar with F10
let g:tagbar_ctags_bin='/usr/local/bin/ctags'  " Proper Ctags locations
let g:tagbar_width=40

" Only do this part when compiled with support for autocommands.
if has("autocmd")

 " Enable extra whitespace highlighting
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()

  highlight TabLineFill ctermbg=red guibg=red

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

"  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
