" " Essential:   properly detects filetype for weird files or corrects them and adds syntax {{{
" augroup detect_filetypes
"   au!
"   " html & css family:
"   au BufNewFile,BufRead *.less setl ft=less
"   au BufNewFile,BufRead *.scss setl ft=scss
"   au BufNewFile,BufRead *.sass setl ft=sass
"   " javascript family:
"   au BufNewFile,BufRead *.json setl ft=json
"   au BufNewFile,BufRead *.coffee{,script} setl ft=coffee
"   au BufNewFile,BufRead *.vue{,js} setl ft=vue
"   " ruby:
"   au BufNewFile,BufRead Rakefile,Capfile,Gemfile,Guardfile,Vagrantfile
"         \,Thorfile,Do,dorc,Dofile,config.ru,.autotest,.irbrc,.pryrc
"         \,.simplecov,*.thor,*.rabl setl ft=ruby
"   " vim and shell files:
"   au BufNewFile,BufRead *vimrc,*.vim setl ft=vim
"   au BufNewFile,BufRead *zshrc*,*zprofile,*zlogin,*zshenv* setl ft=sh
"   " text files
"   au BufNewFile,BufRead *.md,*.mdown,*.markdown setl ft=ghmarkdown
"   " messes help text files
"   " au BufNewFile,BufRead *.txt,*.text setl ft=text
"   " php files
"   au BufNewFile,BufRead *.ctp setl ft=ctp
"   " go
"   au BufNewFile,BufRead *.go setl ft=go
"   " elixir
"   au BufNewFile,BufRead *.ex,*.exs setl ft=elixir
"   au BufNewFile,BufRead *.html.eex setl ft=html
"   " miscelleneous
"   au BufNewFile,BufRead gemrc,*.yml,*.yaml setl ft=yaml
"   au BufNewFile,BufRead config setl ft=dosini
"   au BufNewFile,BufRead *.rasi setl ft=css
" augroup end

" augroup markdown_codedetect
"   au!
"   au filetype html :call SyntaxRange#Include("<style>", "</style>", "css")
"   au filetype html :call SyntaxRange#Include("<style.*sass.*>", "</style>", "scss")
"   au filetype html :call SyntaxRange#Include("<style.*scss.*>", "</style>", "scss")
"   au filetype html :call SyntaxRange#Include("<style.*less.*>", "</style>", "less")
"   au filetype html :call SyntaxRange#Include("<script>", "</script>", "javascript")
"   au filetype html :call SyntaxRange#Include("<script.*coffee.>", "</script>", "coffee")
"   au filetype html :call SyntaxRange#Include("<script.*coffeescript.>", "</script>", "coffee")
" augroup END
" " }}}
" " Essential:   sets up a sane editing/coding environment as per the filetype {{{
"   augroup setup_environment
"     au!
"     au filetype css,less,sass,scss      set ts=2 sw=2 sts=2 tw=80 et
"     au filetype json,javascript,coffee  set ts=2 sw=2 sts=2 tw=80 et
"     au filetype python                  set ts=4 sw=4 sts=4 tw=80  et
"     au filetype ruby,eruby              set ts=2 sw=2 sts=2 tw=120 et
"     au filetype php,ctp                 set ts=4 sw=4 sts=4 tw=80  et
"     au filetype sh,vim                  set ts=2 sw=2 sts=2 tw=72  et
"     au filetype ghmarkdown,textile      set ts=4 sw=4 sts=4 tw=100 et
"     au filetype rst                     set ts=4 sw=4 sts=4 tw=74  et
"     au filetype yaml                    set ts=2 sw=2 sts=2 tw=72  et
"     au filetype html,xhtml,haml         set ts=2 sw=2 sts=2 tw=120 et
"     au filetype make                    set noet " make uses real tabs
"     au filetype vue                     set ts=2 sw=2 sts=2 tw=80 et
"   augroup end
" " }}}
" " Essential:   sets up folding for the current file as per its filetype {{{
"   augroup create_folds
"     au!
"     au filetype css,less,sass,scss set fdm=marker fmr={,}
"     au filetype coffee             set fdm=indent fdls=1
"     au filetype javascript         set fdm=syntax fdls=1
"     au filetype ruby,eruby         set fdm=syntax
"     au filetype sh,zsh,bash,vim    set fdm=marker fmr={{{,}}} fdls=0 fdl=0
"     au filetype yaml,conf          set fdm=marker fmr={{{,}}} fdls=0 fdl=0
"   augroup end
" " }}}
" " Essential:   sets up syntax as per the filetype or other variables {{{
"   augroup syntax_higlighting
"     au!
"     au filetype json,javascript    set syntax=javascript
"     au filetype ctp                set syntax=php
"     " javascript syntax should be enhanced via jquery syntax
"     au syntax   javascript         set syntax=jquery
"   augroup end
" " }}}
" " Essential:   sets up whitespace visibility as per the filetype {{{
"   augroup whitespace
"     au!
"     au filetype ghmarkdown,textile,text,rst set nolist
"     au filetype coffee,javascript set listchars=trail:·,extends:#,nbsp:·
"   augroup end
" " }}}
" " Essential:   turns on spell checking and automatic wrap on text files {{{
"   augroup text_files
"     au!
"     au filetype ghmarkdown,textile,rst set wrap wrapmargin=2
"     au filetype ghmarkdown             set formatoptions+=w
"     au filetype ghmarkdown,textile,rst set formatoptions+=qat
"     au filetype ghmarkdown,textile,rst set formatoptions-=cro
"   augroup end
" " }}}
" " Essential:   has make programs defined for certain languages that does the heavy work {{{
"   " Note: Dispatch does not support filename modifiers like: `%<`.
"   "       Instead, use: `%:r`
"   Plug 'tpope/vim-dispatch'

"   " Press <F6> to run the make command.
"   " To check output, open QuickFix with `<leader>qf` or `:copen`
"   nnoremap <F5> :Dispatch<CR>

"   augroup make_programs
"     au!
"     au filetype php set makeprg=php\ -l\ %    " linting
"     au filetype rst set makeprg=rst2html.py\ %\ /tmp/%:r.html\ &&\ open\ /tmp/%:r.html
"     au filetype ghmarkdown setl makeprg=rdiscount\ %\ >\ /tmp/%:r.html\ &&\ open\ /tmp/%:r.html

"     " allow the following files to run themselves when <F6> is pressed.
"     au filetype sh set makeprg=chmod\ +x\ %:p\ &&\ %:p
"     au BufRead,BufEnter *.{rb,py,php,js} if executable(expand("%:p")) &&
"           \ ( &makeprg == "make" ) | set makeprg=%:p | endif

"     " TODO: use a minifier as a make program for CSS & JS files
"   augroup end
" " }}}
