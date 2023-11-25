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
"" Start NERDTree and leave the cursor in it.

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
let ascii_files = glob('~/Documents/ascii/*.txt', 0, 1)
let rand = system('shuf -i 0-' . string(len(ascii_files) - 1) . ' -n 1')
let g:startify_custom_header = startify#center(readfile(ascii_files[rand]))
highlight StartifyHeader ctermfg=white

" Vim-wiki 
let g:vimwiki_list = [{'path': '~/MEGA/googledrive/textDB/vim-wiki', 'syntax': 'markdown', 'ext': '.md'}]

let g:vimwiki_listsyms = '○◐✗○●✓'
colorscheme notelight
