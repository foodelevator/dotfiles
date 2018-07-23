set nocompatible
filetype plugin indent on
syntax on

autocmd FileType rust set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab

set mouse=a

set number
set title
set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab
set nowrap

noremap ; l
noremap l k
noremap k j
noremap j h

" Spell checking
map <F1> :set nospell<Return>
map <F2> :set spell spelllang=sv<Return>
map <F3> :set spell spelllang=en_us<Return>
map <F4> :set spell spelllang=en_us,sv<Return>

