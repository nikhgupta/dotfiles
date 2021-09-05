Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'thoughtbot/vim-rspec'

" adds block-level end statements when hitting Enter key
Plug 'tpope/vim-endwise'
let g:endwise_no_mappings = 1

" has refactoring support for ruby code
Plug 'ecomba/vim-ruby-refactoring'

" NOTE: `vim-bundler` uses 2 system commands that are expensive.
"       Therefore, we replace it with autocmds instead. Look into:
"       " Ruby: Rails: persist ctags when we move inside gem directories
"
" Plug 'tpope/vim-bundler'
"
" ' system('ruby -rubygems -e "print Gem.path.join(%(;))"')
" ' system('ruby -rrbconfig -e "print RbConfig::CONFIG[\"ruby_version\"]"')

" persist ctags when we move inside gem directories
augroup gem_ctags
  au!
  au filetype ruby,eruby setl tags+=$RBENV_ROOT/versions/*/lib/ruby/gems/*/gems/*/tags
augroup END

" autocomplete ruby - required by rails.vim
augroup omni_complete_ruby
  au!
  autocmd filetype ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd filetype ruby,eruby let g:rubycomplete_rails = 1
  autocmd filetype ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd filetype ruby,eruby let g:rubycomplete_include_object = 1
  autocmd filetype ruby,eruby let g:rubycomplete_include_objectspace = 1
augroup end
