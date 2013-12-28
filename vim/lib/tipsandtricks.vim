" Join lines and restore cursor location (J)
nnoremap J mjJ`j

" Word processor mode (:WP)
func! WordProcessorMode()
  setlocal formatoptions=t1
  setlocal textwidth=100
  map j gj
  map k gk
  setlocal smartindent
  setlocal spell spelllang=en_ca
  setlocal noexpandtab
endfu
com! WP call WordProcessorMode()


" JSON
au BufRead,BufNewFile *.json set ft=json syntax=javascript


" Jade
au BufRead,BufNewFile *.jade set ft=jade syntax=jade

" Ruby
au BufRead,BufNewFile Rakefile,Capfile,Gemfile,.autotest,.irbrc,*.treetop,*.tt set ft=ruby syntax=ruby

" Nu
au BufNewFile,BufRead *.nu,*.nujson,Nukefile setf nu

" Coffee
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

" ZSH
au BufRead,BufNewFile .zsh_rc,.functions,.commonrc set ft=zsh

" Fish
au BufRead,BufNewFile *.fish set ft=fish

" XML
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" Resize splits when the window is resized
au VimResized * :wincmd =


" Use AG

au FileType make set noexpandtab " make uses real tabs"


" Thorfile, Rakefile, GuardFile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Guardfile,Vagrantfile,Thorfile,Do,dorc,Dofile,config.ru} set ft=ruby


" Make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" Git commits
au Filetype gitcommit setlocal spell textwidth=72
au BufRead,BufNewFile GHI_* set ft=gitcommit


" Nginx highlight
au BufRead,BufNewFile /{etc,opt}/nginx/conf/* set ft=nginx


" Enable syntastic syntax checking
let g:syntastic_enable_signs   = 1
let g:syntastic_quiet_warnings = 1




" NERDTree configuration
let NERDTreeQuitOnOpen  = 0   " don't collapse NERDTree when a file is opened
let NERDTreeMinimalUI   = 1
let NERDTreeDirArrows   = 0
let NERDTreeChDirMode   = 0
let NERDTreeIgnore      = ['\.pyc$', '\.rbc$', '\~$']
let NERDTreeHijackNetrw = 0
let g:nerdtree_tabs_startup_cd = 0
" let g:nerdtree_tabs_open_on_console_startup=0
" ca cd NERDTree

" Resize splits when the window is resized
" au VimResized * :wincmd =

" open the Gdiff in a separate tab
" TODO: close the nerdTree therein.
command! GdiffInTab tabedit %|Gdiff
nnoremap <leader>d :GdiffInTab<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" Tab movements & creation
map <C-S-Left> gT
map <C-S-Right> gt
imap <C-S-Left> <ESC>gT
imap <C-S-Right> <ESC>gt



" CtrlP
" Additional mapping for buffer search
map <C-l> :CtrlPBufTag<CR>
imap <C-l> <ESC>:CtrlPBufTag<CR>

map <C-k> :CtrlPBuffer<CR>
imap <C-k> <ESC>:CtrlPBuffer<CR>

" Standard CtrlP also in insert mode
imap <C-p> <ESC>:CtrlP<CR>

" CTRLP Mappings
macmenu &File.Print key=<D-M-p>
map <D-p> :CtrlP<CR>
imap <D-p> <ESC>:CtrlP<CR>
map <D-P> :CtrlPBuffer<CR>
imap <D-P> <ESC>:CtrlPBuffer<CR>
let base16colorspace=256  " Access colors present in 256 colorspace

  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist


" send all miscellenous autocommands to a single group


" Edit the README_FOR_APP (makes :R commands work)
map <Leader>R :e doc/README_FOR_APP<CR>

" Leader shortcuts for Rails commands
map <Leader>m :Rmodel 
map <Leader>c :Rcontroller 
map <Leader>v :Rview 
map <Leader>u :Runittest 
map <Leader>f :Rfunctionaltest 
map <Leader>tm :RTmodel 
map <Leader>tc :RTcontroller 
map <Leader>tv :RTview 
map <Leader>tu :RTunittest 
map <Leader>tf :RTfunctionaltest 
map <Leader>sm :RSmodel 
map <Leader>sc :RScontroller 
map <Leader>sv :RSview 
map <Leader>su :RSunittest 
map <Leader>sf :RSfunctionaltest 


" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

" execute current line in vim
map <leader>s <Esc>"ayy:@a<CR>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

nmap <C-tab> :bn<CR>
imap <C-tab> <ESC>:bn<CR>i


" Edit routes
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"


" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;


" As a convenience, a user command (named R) can be defined to allow easy capture of output in a scratch buffer:
:command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

set gcr=a:blinkon0              "Disable cursor blink

" TODO: implement? https://github.com/astashov/vim-ruby-debugger
