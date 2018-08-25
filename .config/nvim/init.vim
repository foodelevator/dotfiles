call plug#begin('~/.config/nvim/plug')
Plug 'altercation/vim-colors-solarized'
Plug 'bronson/vim-trailing-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/echodoc.vim'
" Plug 'rust-lang/rust.vim'
call plug#end()

autocmd! bufwritepost init.vim source %

" File Tree:
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_altv=1

" Indent Guides:
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter * :hi IndentGuidesOdd  ctermbg=8
autocmd VimEnter * :hi IndentGuidesEven ctermbg=0

" Search Down Into Subdirectories:
set path+=**

" Syntax Highlighting:
filetype plugin indent on
syntax on

" Color Scheme:
set background=dark
colorscheme solarized

" Language Client:
let g:LanguageClient_serverCommands = {
    \ 'rust': ['/usr/bin/rustup', 'run', 'stable', 'rls'],
	\ }

" Language Server:
let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_serverStderr = '/tmp/LanguageServer.log'

" Function Paramater Helper:
let g:echodoc#enable_at_startup = 1
set cmdheight=2

" Common Sense:
set ignorecase
set incsearch
set mouse=a
set nohlsearch
set nowrap
set number
set scrolloff=3
set smartcase
set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab
set title

let mapleader = ","

" More Common Sense:
noremap ; l
noremap l k
noremap k j
noremap j h

" Make Y Work Like D Or C:
noremap Y y$

" Move Around Between Multiple Windows:
map <silent> <c-j> :wincmd h<CR>
map <silent> <c-k> :wincmd j<CR>
map <silent> <c-l> :wincmd k<CR>
map <silent> <c-h> :wincmd l<CR>

map <silent> <a-j> :wincmd H<CR>
map <silent> <a-k> :wincmd J<CR>
map <silent> <a-l> :wincmd K<CR>
map <silent> <a-;> :wincmd L<CR>

" Stay In Visual Mode When Indenting:
vnoremap < <gv
vnoremap > >gv

" Spell Checking:
map <F1> :set nospell<Return>
map <F2> :set spell spelllang=sv<Return>
map <F3> :set spell spelllang=en_us<Return>
map <F4> :set spell spelllang=en_us,sv<Return>
set spell spelllang=en_us,sv

" Use Tab For Completion:
function! CleverTab()
	if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
		return "\<Tab>"
	else
		return "\<C-N>"
	endif
endfunction
inoremap <silent> <Tab> <C-R>=CleverTab()<CR>

" Save With Control S:
imap <c-s> <Esc>:w<CR>
map <c-s> :w<CR>

" Cursor Placeholders:
imap <c-Space> <Esc>/<\~\~><CR>"_c4;

" Snippets And Skeletons:
nmap <leader>html :-1read ~/.config/nvim/skeletons/html<CR>5kf>a

map <c-c>  "+y
map <c-p>  "+p
imap <c-v> <c-r>+
vmap <leader>s :sort<CR>
imap <c-k> <c-n>
imap <c-l> <c-p>

" Rust Specific:

" Tags:
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" Hard Tabs Fix:
autocmd FileType rust set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab

" Cargo Commands:
autocmd FileType rust map <F5> :!cargo run<CR>
autocmd FileType rust imap <F5> <Esc>:!cargo run<CR>

autocmd FileType rust map <F6> :!cargo doc --open<CR>
autocmd FileType rust imap <F6> <Esc>:!cargo doc --open<CR>

