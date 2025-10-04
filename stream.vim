" ~/.config/nvim/stream.vim  — bare, quiet, readable
set nocompatible
filetype plugin indent on
syntax on
set termguicolors

" Nuke the chrome
set laststatus=0 noshowmode noruler
set nocursorcolumn nocursorline
set signcolumn=no
set nonumber norelativenumber
set nofoldenable foldcolumn=0 colorcolumn=

" Keep it from being “editable” on stream
augroup StreamView
  autocmd!
  autocmd BufReadPost,BufNewFile * setlocal readonly nomodifiable
augroup END
