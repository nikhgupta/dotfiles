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

" " list of available checkers:
" " https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers
" let g:syntastic_python_checkers  = ['flake8']
" let g:syntastic_ruby_checkers  = ['mri', 'rubocop']
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
