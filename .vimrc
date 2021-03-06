" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

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

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" User Settings from here "

" Set TAB as space
set ts=4
set expandtab
set shiftwidth=4
set nu

" Ctags
map <C-r> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>

" Taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

" OmniCppComplete
set nocp
filetype plugin on

" Minibufferexplorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplmapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplMoreThanOne = 0

" NerdTree
let g:NERDTree_title="[NERDTree]"
let g:winManagerWIndowLayout="NERDTree|Taglist"

function! NERDTree_Start()
    exec 'NERDTree'
endfunction

function! NERDTree_IsValid()
    return 1
endfunction

nmap wm :WMToggle<cr>

" Set  mapleader
let mapleader = ","
let g:molokai_original = 1

set background=dark
"colorscheme solarized
colorscheme molokai

" Fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<cr>

" Fast editing of .vimrc
map <silent> <leader>ee :e ~/.vimrc<cr>

" When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

" auto load workspace information
if filereadable(".workspace.vim")
    source .workspace.vim
endif

" Taglist toggle cmd map
map <silent> <leader>tt :TlistToggle<cr>
nmap tt :TlistToggle<cr>
" CScope Settings
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
    "set cscopequickfix=s-,c-,d-,i-,t-,e-
endif


nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

set nocompatible                " be iMproved
filetype off                    " required!
set rtp+=~/.vim/vundle.git/
call vundle#rc()

" let Vundle manage Vundle
" Bundle 'gmarik/vundle'
"
" "my Bundle here:
" "
" " original repos on github
Bundle 'kien/ctrlp.vim'
 Bundle 'sukima/xmledit'
 Bundle 'sjl/gundo.vim'
 Bundle 'jiangmiao/auto-pairs'
 Bundle 'klen/python-mode'
 Bundle 'Valloric/ListToggle'
 Bundle 'SirVer/ultisnips'
 Bundle 'Valloric/YouCompleteMe'
 Bundle 'scrooloose/syntastic'
 Bundle 't9md/vim-quickhl'
 " Bundle 'Lokaltog/vim-powerline'
 Bundle 'scrooloose/nerdcommenter'
 "..................................
 " vim-scripts repos
 Bundle 'YankRing.vim'
 Bundle 'vcscommand.vim'
 Bundle 'ShowPairs'
 Bundle 'SudoEdit.vim'
 Bundle 'EasyGrep'
 Bundle 'VOoM'
 Bundle 'VimIM'
 Bundle 'ShowTrailingWhitespace'
 Bundle 'altercation/vim-colors-solarized'
 Bundle 'taglist.vim'
 Bundle 'minibufexplorerpp'
 Bundle 'scrooloose/nerdtree'
 Bundle 'jistr/vim-nerdtree-tabs'
 "..................................
 " non github repos
 " Bundle 'git://git.wincent.com/command-t.git'
 "......................................
 filetype plugin indent on


map <Leader>n <plug>NERDTreeTabsToggle<CR>

" 插入模式下移动光标快捷键
imap <c-j> <down>
imap <c-k> <up>
imap <c-h> <left>
imap <c-l> <right>
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlP'

let g:ycm_confirm_extra_conf = 0
