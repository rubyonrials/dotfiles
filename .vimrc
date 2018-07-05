set nocompatible

" Plug https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Automatically executes filetype plugin indent on and syntax enable
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'           " ,g
Plug 'altercation/vim-colors-solarized' " colors
Plug 'austintaylor/vim-indentobject'    " ii, ai objects (vii, gcai)
Plug 'christoomey/vim-tmux-navigator'   " ctrl-hjkl
Plug 'ctrlpvim/ctrlp.vim'               " ,t ,b
Plug 'rking/ag.vim'                     " ,a
Plug 'scrooloose/nerdtree'              " ,d ,f
Plug 'tpope/vim-commentary'             " gc
Plug 'tpope/vim-fugitive'               " :Gblame, Gdiff, Gstatus
Plug 'tpope/vim-repeat'                 " Augments .
Plug 'tpope/vim-surround'               " cs<existing><desired> ds<existing>
Plug 'vim-scripts/Align'                " ,l
Plug 'vim-scripts/greplace.vim'         " :Greplace
Plug 'sheerun/vim-polyglot'             " Multi-lang syntax highlighting
Plug 'w0rp/ale'                         " Async linting
call plug#end()

set autoindent
set autoread                         " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                      " Fix broken backspace in some setups
set backupcopy=yes                   " see :help crontab
set clipboard=unnamed                " yank and paste with the system clipboard
set directory-=.                     " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                        " expand tabs to spaces
set ignorecase                       " case-insensitive search
set incsearch                        " search as you type
set laststatus=2                     " always show statusline
set list                             " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number                           " show line numbers
set ruler                            " show where you are
set scrolloff=3                      " show context above/below cursorline
set shiftwidth=2                     " normal mode indentation commands use 2 spaces
set showcmd
set smartcase                        " case-sensitive search if any caps
set softtabstop=2                    " insert mode tab and backspace use 2 spaces
set tabstop=8                        " actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                         " show a navigable menu for tab completion
set wildmode=longest,list,full
set splitbelow                       " split panes to right and bottom
set splitright

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" keyboard shortcuts
let mapleader = ','
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <leader>l :Align
nnoremap <leader>a :Ag<space>
" bind F to grep word under cursor
nnoremap <leader>A :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
nnoremap <leader>g :GitGutterToggle<CR>
noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

" plugin settings
let g:ctrlp_match_window='order:ttb,max:20'
let g:NERDSpaceDelims=1
let g:NERDTreeShowHidden=1
let g:gitgutter_enabled=0
let g:ale_lint_on_text_changed='never'
let g:ale_javascript_flow_executable='yarn flow'
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\}

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" https://robots.thoughtbot.com/faster-grepping-in-vim
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP
set nocursorline " don't highlight current line

" highlight search
set hlsearch
nmap <leader>hl :let @/ = ""<CR>

" gui settings
if (&t_Co == 256 || has('gui_running'))
  colorscheme solarized
endif

" Disambiguate ,a & ,t from the Align plugin, making them fast again.
function! s:RemoveConflictingAlignMaps()
  if exists("g:loaded_AlignMapsPlugin")
    AlignMapsClean
  endif
endfunction
command! -nargs=0 RemoveConflictingAlignMaps call s:RemoveConflictingAlignMaps()
silent! autocmd VimEnter * RemoveConflictingAlignMaps

" Highlight column 98
highlight ColorColumn ctermbg=7
call matchadd('ColorColumn', '\%98v', 100)
