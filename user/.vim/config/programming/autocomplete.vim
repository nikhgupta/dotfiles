set completeopt+=menu,longest     " select first item, follow typing in autocomplete
set complete=.,w,b,u,t            " do lots of scanning on tab completion,  FIXME?
set pumheight=6                   " Keep a small completion window

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

set completeopt+=preview          " enable doc preview in omnicomplete

" Mapping: quickly complete file names or lines from current buffer in insert mode
imap <C-f> <C-x><C-f>
imap <C-l> <C-x><C-l>

" Disable the neosnippet preview candidate window
" When enabled, there can be too much visual noise
" especially when splits are used.
" set completeopt-=preview

" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" " enable completion from tags
" let g:ycm_collect_identifiers_from_tags_files = 1
" " enable completion for keywords in current language
" let g:ycm_seed_identifiers_with_syntax = 0
" let g:ycm_max_num_candidates = 10

" augroup load_us_ycm
"   autocmd!
"   autocmd InsertEnter * call plug#load('ultisnips', 'vim-snippets', 'ZouCompleteMe')
"         \| autocmd! load_us_ycm
" augroup END
" php
Plug 'shawncplus/phpcomplete.vim'

" Enable omni completion.
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

" ruby - required by rails.vim
augroup omni_complete_ruby
  au!
  autocmd filetype ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd filetype ruby,eruby let g:rubycomplete_rails = 1
  autocmd filetype ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd filetype ruby,eruby let g:rubycomplete_include_object = 1
  autocmd filetype ruby,eruby let g:rubycomplete_include_objectspace = 1
augroup end
" 
