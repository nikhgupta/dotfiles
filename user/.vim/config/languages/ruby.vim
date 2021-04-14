Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'thoughtbot/vim-rspec'

  " NOTE: `vim-bundler` uses 2 system commands that are expensive.
  "       Therefore, we replace it with autocmds instead. Look into:
  "       " Ruby: Rails: persist ctags when we move inside gem directories
  "
  " Plug 'tpope/vim-bundler'
  "
  " ' system('ruby -rubygems -e "print Gem.path.join(%(;))"')
  " ' system('ruby -rrbconfig -e "print RbConfig::CONFIG[\"ruby_version\"]"')

" Expedite:    adds block-level end statements when hitting Enter key {{{
Plug 'tpope/vim-endwise'
" }}}
" Personalize: persist ctags when we move inside gem directories {{{
  augroup gem_ctags
    au!
    au filetype ruby,eruby setl tags+=$RBENV_ROOT/versions/*/lib/ruby/gems/*/gems/*/tags
  augroup END
" }}}
" Personlize:  has command to quickly run specs {{{
" NOTE: this depends on vim-rspec plugin
  function! RunSpecs(...)
    let l:inside_app   = expand("%:h") =~ "app"
    let l:is_spec_file = expand("%:h") =~ "spec"
    if l:is_spec_file
      let l:path = expand("%")
    else
      let l:path = "spec/" . expand("%:h:t") . "/" . expand("%:t:r:r:r:r:r") . "_spec.rb"
      let l:path = substitute(l:path, "_spec_spec.rb", "_spec.rb", "g")
    end
    if filereadable(l:path)
      let l:path = a:0 && !empty(a:1) ? fnamemodify(l:path, a:1) : l:path
      let l:path = a:0 < 2 || empty(a:2) || l:inside_app ? l:path : l:path . a:2
      echo "Running specs: " . l:path
      execute substitute(g:rspec_command, "{spec}", l:path, "g")
    else
      echohl WarningMsg | echo "No such file found: " . l:path | echohl None
    endif
  endfunction
  let g:rspec_runner = "os_x_iterm2"
  if g:is_gui
    let g:rspec_command = 'Dispatch bundle exec bin/rspec {spec}'
  else
    let g:rspec_command = 'call VimuxRunCommand(" bin/rspec {spec}")'
  endif
  map <Leader>rsf :call RunSpecs()<CR>
  map <Leader>rsn :call RunSpecs("", ":" . line("."))<CR>
  map <Leader>rsl :call RunLastSpec()<CR>
  map <Leader>rsa :call RunSpecs(":h:h")<CR>
  map <Leader>rsg :call RunSpecs(":h")<CR>
" }}}
" Specialize:  has refactoring support for ruby code {{{
  Plug 'ecomba/vim-ruby-refactoring'
" }}}
