set nocompatible              " be iMproved, required
let $LANG='en_US.utf8'
set langmenu=en_US.utf8
filetype off                  " required
set guifont=Liberation\ Mono\ Regular\ 18 " For gVim
set linebreak
set relativenumber
set background=dark
syntax on 
set number
set ruler
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set backspace=eol,start,indent
set whichwrap-=Left,Right
set ignorecase " Ignore case when searching
set hlsearch " Highlight search results
set magic " For regular expressions turn magic on
set showmatch " Show matching brackets when text indicator is over them
set mat=2 " How many tenths of a second to blink when matching brackets
set noerrorbells " No annoying sound on errors
" set novisualbell "disables the visual cue (like flashing the screen) that indicates an error or alert in place of an audible bell.
set t_vb=
set tm=500
set foldcolumn=1 " Add a bit extra margin to the left
set wildmenu " Turn on the Wild menu
set wildignore=*.o,*~,*.pyc " Ignore compiled files
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
set incsearch " Makes search act like search in modern browsers
set encoding=UTF-8
set ffs=unix,dos,mac
set clipboard=unnamedplus " Change default clipboard buffer
set mouse=a
set spelllang=ru_ru " Set spellcheck language
set ttimeoutlen=10 " Reduce delay when switching from Insert mode to Normal mode using the `<Esc>` key
highlight Normal guibg=black guifg=white
autocmd VimLeave * call system("xsel -ib", getreg('+')) " prevent Vim from clearing the clipboard upon exit
