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
" Color schemes 
Plugin 'sainnhe/gruvbox-material'
Plugin 'pacokwon/onedarkhc.vim'
Plugin 'sainnhe/sonokai'
Plugin 'yasukotelin/notelight'
Plugin 'tomasiser/vim-code-dark'
call vundle#end()            " required

filetype plugin indent on    " required

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
let g:airline_theme = 'codedark'
let g:codedark_modern=1
" Activates italicized comments (make sure your terminal supports italics)
let g:codedark_italics=1
set background=dark
colorscheme codedark
