call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'kien/ctrlp.vim'
Plug 'rizzatti/dash.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" General configs
syntax on
set number relativenumber
set encoding=utf-8

" Cursor
set cursorline
hi cursorline cterm=underline

" Colorsheme
silent! colorscheme desertink

" Airline configs
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline_theme='wombat'
