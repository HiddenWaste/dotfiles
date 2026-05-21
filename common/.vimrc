syntax on " syntax for code 
set number " enable line numbers (top to bottom of file)
set mouse=a " allow usage of the mouse to move and select
set tabstop=4 " space tabs use
set expandtab " auto indentation in functions and such

" Create the directory if it doesn't exist (optional but helpful)
silent !mkdir -p ~/tmp/swp/ > /dev/null 2>&1

" Set the directory for swap files
set directory=~/tmp/swp//

" Bonus: Also redirect undo and backup files to keep things clean
set backupdir=~/tmp/swp//
set undodir=~/tmp/swp//
