" https://github.com/nvie/vimrc/blob/master/vimrc
" ===============================================
" Run tests
" ---------
" nnoremap <leader>w :write | :!./run_tests.sh<cr>
" inoremap <leader>w <esc><leader>w

" Split previously opened file ('#') in a split window
" ----------------------------------------------------
" nnoremap <leader>sh :execute 'leftabove vsplit' bufname('#')<cr>
" nnoremap <leader>sl :execute 'rightbelow vsplit' bufname('#')<cr>

" Define operator-pending mappings to quickly apply commands to function names
" and/or parameter lists in the current line
" onoremap inf :<c-u>normal! 0f(hviw<cr>
" onoremap anf :<c-u>normal! 0f(hvaw<cr>
" onoremap in( :<c-u>normal! 0f(vi(<cr>
" onoremap an( :<c-u>normal! 0f(va(<cr>

" https://github.com/gf3/dotfiles/blob/master/.vimrc
" ==================================================
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set encoding=utf-8 nobomb " BOM often causes trouble
set esckeys " Allow cursor keys in insert mode.
set foldminlines=0 " Allow folding single lines
set foldnestmax=3 " Set max fold nesting level
set showtabline=2 " Always show tab bar.
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/smarty/*,*/vendor/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*
set wildchar=<TAB> " Character for CLI expansion (TAB-completion).
set winminheight=0 "Allow splits to be reduced to a single line.
set wrapscan " Searches wrap around end of file


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
let g:ackprg = 'ag --nogroup --nocolor --column'

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


" Stop fucking netrw
let g:netrw_silent = 1
let g:netrw_quiet  = 1
let g:loaded_netrw = 1



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

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" open the Gdiff in a separate tab
" TODO: close the nerdTree therein.
command! GdiffInTab tabedit %|Gdiff
nnoremap <leader>d :GdiffInTab<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Md5 COMMAND
" Show the MD5 of the current buffer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5')

" insert time
command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>

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


if exists("&cryptmethod")
  set cryptmethod=blowfish " https://coderwall.com/p/hypjbg
endif


let base16colorspace=256  " Access colors present in 256 colorspace
set background=light
colorscheme soda

" Verical bar in insert mode (for iTerm users only)
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"


" Ctrol-E to switch between 2 last buffers
" nmap <C-E> :b#<CR>

" ,e to fast finding files. just type beginning of a name and hit TAB
" nmap <leader>e :e **/


" center display after searching
" nnoremap n   nzz
" nnoremap N   Nzz
" nnoremap *   *zz
" nnoremap #   #zz
" nnoremap g*  g*zz
" nnoremap g#  g#z


" emacs movement keybindings in insert mode
imap <C-a> <C-o>0
imap <C-e> <C-o>$
map <C-e> $
map <C-a> 0


" make file executable
command -nargs=* Xe !chmod +x <args>
command! -nargs=0 Xe !chmod +x %


" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif


" Switch between the last two files
nnoremap <leader><leader> <c-^>


" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>


" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1


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


" Edit routes
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb



" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif



" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"


" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;


" As a convenience, a user command (named R) can be defined to allow easy capture of output in a scratch buffer:
:command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

set gcr=a:blinkon0              "Disable cursor blink

" TODO: implement? https://github.com/astashov/vim-ruby-debugger
