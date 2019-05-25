" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim74/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

if !exists("autocommands_loaded")
  let autocommands_loaded = 1
endif

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

syntax on
filetype plugin indent on
colorscheme desert

autocmd ColorScheme * highlight PmenuSel ctermfg=black ctermbg=white
autocmd ColorScheme * highlight PMenu ctermfg=white ctermbg=darkgray

set background=dark

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8

"let g:jedi#auto_initialization = 0
"let g:jedi#popup_on_dot = 0
autocmd FileType python setlocal completeopt-=preview

set mouse-=a
