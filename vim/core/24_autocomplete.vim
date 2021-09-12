set completeopt+=menu,longest     " select first item, follow typing in autocomplete
set complete=.,w,b,u,t            " do lots of scanning on tab completion,  FIXME?
set pumheight=6                   " Keep a small completion window

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

set completeopt+=preview          " enable doc preview in omnicomplete

" quickly complete file names or lines from current buffer in insert mode
inoremap <C-f> <C-x><C-f>
inoremap <C-l> <C-x><C-l>

" autocomplete for some standard filetypes
augroup omni_complete
  au!
  if exists('+omnifunc')
    " Enable omni completion for filetypes (Ctrl-X Ctrl-O)
    autocmd filetype html,ghmarkdown set omnifunc=htmlcomplete#CompleteTags
    autocmd filetype javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd filetype python set omnifunc=pythoncomplete#Complete
    autocmd filetype xml set omnifunc=xmlcomplete#CompleteTags
    autocmd filetype c set omnifunc=ccomplete#Complete
    autocmd filetype css set omnifunc=csscomplete#CompleteCSS
    autocmd filetype java set omnifunc=javacomplete#Complete
    autocmd filetype xml set omnifunc=xmlcomplete#CompleteTags
    autocmd filetype haskell set omnifunc=necoghc#omnifunc
    autocmd filetype ruby set omnifunc=rubycomplete#Complete

    " use syntax complete if nothing else available
    autocmd filetype * if &omnifunc == '' | set omnifunc=syntaxcomplete#Complete | endif
  endif
augroup end
