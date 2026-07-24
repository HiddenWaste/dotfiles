syntax on " syntax for code 
set number " enable line numbers (top to bottom of file)
set mouse=a " allow usage of the mouse to move and select
set tabstop=4 " space tabs use
set expandtab " auto indentation in functions and such

" Automatically indent new lines to match the previous line
set autoindent

" Smart indentation that understands code blocks (C, C++, Java, etc.)
set smartindent

" Automatically detect file type and apply indentation rules specific to it
filetype plugin indent on

" Number of spaces to use for each step of (auto)indent
set shiftwidth=4

" Create the directory if it doesn't exist (optional but helpful)
silent !mkdir -p ~/tmp/swp/ > /dev/null 2>&1

" Set the directory for swap files
set directory=~/tmp/swp//

" Bonus: Also redirect undo and backup files to keep things clean
set backupdir=~/tmp/swp//
set undodir=~/tmp/swp//

" Initialize vim-plug
call plug#begin('~/.vim/plugged')

" Plugins section
Plug 'tpope/vim-commentary'

" The core binary finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" The Vim integration plugin (This gives you commands & mappings)
Plug 'junegunn/fzf.vim'

" End plugin setup
call plug#end()

" Map Ctrl+/ in Normal mode and Visual mode
nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>
nnoremap <C-p> :Files<CR>
