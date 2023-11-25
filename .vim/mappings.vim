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
