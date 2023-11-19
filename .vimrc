set nocompatible              " be iMproved, required
let $LANG='en_US.utf8'
set langmenu=en_US.utf8
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
Plugin 'vim-airline/vim-airline'
Plugin 'vimwiki/vimwiki'
Plugin 'ryanoasis/vim-devicons'
Plugin 'mhinz/vim-startify'
Plugin 'sainnhe/gruvbox-material'
Plugin 'pacokwon/onedarkhc.vim'
Plugin 'sainnhe/sonokai'
Plugin 'yasukotelin/notelight'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
"   non-Plugin stuff after this line
"
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

"""" Custom mappings

" The imap command is used to create the mapping so that it only applies while in insert mode
imap jj <Esc>
nnoremap <C-/> :nohlsearch<CR>
nnoremap <F1> :NERDTreeToggle<CR>
nnoremap <F2> :NERDTreeToggle /home/bernd/MEGA/googledrive/textDB/<CR>
nnoremap <F3> :browse oldfiles<CR>
" not copying text to the default register when deleting
nnoremap D "_D
vnoremap d "_d
vnoremap D "_D
"create an empty line below the current cursor position without entering insert mode
nnoremap _ :put_<CR>
" toggle spellchecking
noremap <C-s> :setlocal spell! spelllang=ru<CR> 
inoremap <C-s> :setlocal spell! spelllang=ru<CR>
" Better tab experience - from https://webdevetc.com/
map <leader>tn :tabnew<cr>
map <leader>tt :tabnext<cr>
map <leader>tm :tabmove
map <leader>tw :tabclose<cr>
map <leader>to :tabonly<cr>
" Insert current date stamp
inoremap <F5> <C-R>=strftime("%c")<CR>
nnoremap <F5> "=strftime("%c")<CR>P

autocmd VimLeave * call system("xsel -ib", getreg('+')) " prevent Vim from clearing the clipboard upon exit

"""" Plugin settings 

" Start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree /home/bernd/Documents
let g:vim_markdown_folding_disabled = 1
" VIM-Airline 
let g:airline_left_sep='>'
let g:airline_stl_path_style = 'short'
let g:airline_detect_paste=1
set noshowmode
" Startify
" Print current date
"function! s:HeaderFunction() abort
"  return [strftime('%c')]
"endfunction
"let g:startify_custom_header = s:HeaderFunction()
"let g:startify_custom_header = ["test"]

let g:startify_lists = [
            \ { 'type': 'files',     'header':startify#center(['   MRU'])            },
            \ { 'type': 'bookmarks', 'header':startify#center( ['   Bookmarks'])      },
            \ ]

let g:startify_bookmarks = [{'v': '~/.vimrc'}, {'z': '~/.zshrc'}] " Adding bookmarks
" Show random ascii art from a text file
let ascii_files = glob('/home/bernd/Documents/ascii/*.txt', 0, 1)
let rand = system('shuf -i 0-' . string(len(ascii_files) - 1) . ' -n 1')
let g:startify_custom_header = startify#center(readfile(ascii_files[rand]))
highlight StartifyHeader ctermfg=white

" Vim-wiki 
let g:vimwiki_list = [{'path': '/home/bernd/MEGA/googledrive/textDB/vim-wiki', 'syntax': 'markdown', 'ext': '.md'}]

let g:vimwiki_listsyms = '○◐✗○●✓'
colorscheme notelight
