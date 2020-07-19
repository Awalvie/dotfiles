"        _
"       (_)
" __   ___ _ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

" Set map leader
let mapleader =","

" install vim-plug if it isn't already installed
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif


" Install the necesary plugins
call plug#begin('~/.config/nvim/plugged')

" intellisense for vim
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" surround things with different things
Plug 'tpope/vim-surround'
" Fuzzy file finder
Plug 'kien/ctrlp.vim'
" File naivator
Plug 'scrooloose/nerdtree'
" Main theme for vim
Plug 'morhetz/gruvbox'
" Distraction free mode when writing prose
Plug 'junegunn/goyo.vim'
" Statusline theme for gruvbos
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plugin for auto-completing closing brackets
Plug 'raimondi/delimitmate'
" Plugin for quickly commenting out code
Plug 'preservim/nerdcommenter'

call plug#end()

" color support for tmux
if (has("termguicolors"))
  set termguicolors
endif

" general settings
filetype plugin on
filetype indent on
syntax on
set tabstop=2
set shiftwidth=2
set autoindent
set ignorecase
set encoding=utf-8
set number relativenumber
set clipboard+=unnamedplus

" taken from drew devault's dotfiles
" https://git.sr.ht/~sircmpwn/dotfiles/tree/master/.vimrc

" Don't litter swp files everywhere
set backupdir=~/.cache
set directory=~/.cache

" Ex mode is fucking dumb
nnoremap Q <Nop>
set magic

" always have lines above and below you when scrolling
set scrolloff=3
set sidescroll=3

" Search as you type, highlight results
set incsearch
set showmatch
set hlsearch

" Preferences for various file formats
autocmd FileType c setlocal noet ts=8 sw=8 tw=80 cc=80
autocmd FileType h setlocal noet ts=8 sw=8 tw=80 cc=80
autocmd FileType cpp setlocal noet ts=8 sw=8 tw=80 cc=80

" themeing
set background=dark
set termguicolors
let g:gruvbox_italic=1
colorscheme gruvbox
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" buffer navigation and management
set hidden
nmap <leader>T :enew<cr>
" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>
" Delete current buffer"
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Goyo plugin makes text more readable when writing prose:
map <leader>g :Goyo \| set linebreak<CR>

" Nerd tree
map <leader>n :NERDTreeToggle<CR>
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" delimitmate end expand bracket to newline
let delimitMate_expand_cr=1

" disable highlighting
map <leader><space> :noh<CR>

" Enable autocompletion:
set wildmode=longest,list,full

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" turn on spell check for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Remembers last position of the cursor
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" nerdcommenter config
let g:NERDSpaceDelims = 1

" COC keymaps stolen from https://github.com/NerdyPepper/dotfiles
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<Plug>delimitMateCR"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
