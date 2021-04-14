" Plug 'Chiel92/vim-autoformat'
" noremap <F4> :Autoformat<CR>:w<CR>

Plug 'dense-analysis/ale'
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'ruby': ['rubocop', 'rufo', 'sorbet', 'standardrb'],
      \ }


" Plug 'neomake/neomake'
" autocmd! BufWritePost * Neomake
" let g:neomake_ruby_enabled_makers = ['mri', 'rubocop']
" let g:neomake_python_enabled_makers = ['pep8', 'pylint']

" Plug 'scrooloose/syntastic'
" let g:syntastic_check_on_open            = 1
" let g:syntastic_aggregate_errors         = 0
" let g:syntastic_auto_jump                = 2
" let g:syntastic_enable_signs             = 1
" let g:syntastic_auto_loc_list            = 2
" let g:syntastic_error_symbol             = '✗'
" let g:syntastic_warning_symbol           = '⚠'
" let g:syntastic_style_error_symbol       = '☢'
" let g:syntastic_style_warning_symbol     = '☢'
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_enable_balloons          = 1
" let g:syntastic_enable_highlighting      = 1
" let g:syntastic_id_checkers              = 1
"
" " list of available checkers:
" " https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers
" let g:syntastic_python_checkers  = ['flake8']
" let g:syntastic_ruby_checkers  = ['mri', 'rubocop']
" let g:syntastic_ruby_rubocop_exec = expand("$RBENV_ROOT/shims/rubocop-no-warning")
" let g:syntastic_mode_map = { "mode": "passive",
"                             \ "active_filetypes": ["ruby", "php", "python"],
"                             \ "passive_filetypes": ["html"] }
" function! ToggleErrors()
"     let old_last_winnr = winnr('$')
"     lclose
"     if old_last_winnr == winnr('$')
"         " Nothing was closed, open syntastic error location panel
"         Errors
"     endif
" endfunction
" nnoremap <silent> <leader>tl :<C-u>call ToggleErrors()<CR>
" " enable integration with airline
" let g:airline#extensions#syntastic#enabled = 1

" " haskell
" FIXME: move this into Syntastic itself?
" " Haskell post write lint and check with ghcmod
" " $ `cabal install ghcmod` if missing and ensure
" " ~/.cabal/bin is in your $PATH.
" if !executable("ghcmod")
"   autocmd BufWritePost *.hs GhcModCheckAndLintAsync
" endif
