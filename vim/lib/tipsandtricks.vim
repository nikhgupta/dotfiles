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

