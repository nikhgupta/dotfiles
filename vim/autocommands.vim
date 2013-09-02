if has("autocmd")
  match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'  " highlight conflict markers
  augroup miscelleneous           " {{{
    au!
    " toggle relative line numbering
    autocmd FocusLost   * :set number
    autocmd FocusGained * :set relativenumber
    autocmd InsertEnter * :set number
    autocmd InsertLeave * :set relativenumber

    " Restore cursor position upon reopening files
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  augroup end " }}}
  augroup invisible_chars         " {{{
    au!

    " Show invisible characters in all of these files
    autocmd filetype vim setlocal list
    autocmd filetype python,rst setlocal list
    autocmd filetype ruby setlocal list
    autocmd filetype javascript,css setlocal list
  augroup end "}}}
  augroup vim_files               " {{{
      au!

      " Reload Vim Configuration automatically (FIXME??) {{{
      " if has("autocmd")
        " augroup AutoReloadVimRC
          " au!
          " " automatically reload vimrc when it's saved
          " au BufWritePost $MYVIMRC so $MYVIMRC
          " " au BufWritePost $MYVIMRC call Pl#Load()
        " augroup END
      " endif
      " }}}
      autocmd filetype vim setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 textwidth=120
      autocmd filetype vim setlocal foldmethod=marker foldmarker={{{,}}} foldlevel=0
      " Bind <F3> to show the keyword under cursor
      " general help can still be entered manually, with :h
      autocmd filetype vim noremap <buffer> <F3> <Esc>:help <C-r><C-w><CR>
      autocmd filetype vim noremap! <buffer> <F3> <Esc>:help <C-r><C-w><CR>
  augroup end "}}}
  augroup html_files              " {{{
      au!

      autocmd BufNewFile,BufRead *.html,*.htm call s:DetectHTMLVariant()
      autocmd filetype html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
      " Auto-closing of HTML/XML tags
      autocmd filetype html,htmldjango,xhtml,haml let b:closetag_html_style=1
      autocmd filetype html,htmldjango,xhtml,haml let b:closetag_default_xml=1
  augroup end " }}}
  augroup python_files            " {{{
    au!
    autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()
    autocmd BufNewFile,BufRead *.jinja set syntax=htmljinja
    autocmd BufNewFile,BufRead *.mako set ft=mako

    " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
    " earlier, as it is important)
    autocmd filetype python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
    autocmd filetype python setlocal textwidth=80
    autocmd filetype python match ErrorMsg '\%>80v.\+'

    " But disable autowrapping as it is super annoying
    autocmd filetype python setlocal formatoptions-=t

    " Folding for Python (uses syntax/python.vim for fold definitions)
    "autocmd filetype python,rst setlocal nofoldenable
    "autocmd filetype python setlocal foldmethod=expr

    " Python runners
    autocmd filetype python map <buffer> <F5> :w<CR>:!python %<CR>
    autocmd filetype python imap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
    autocmd filetype python map <buffer> <S-F5> :w<CR>:!ipython %<CR>
    autocmd filetype python imap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

    " Run a quick static syntax check every time we save a Python file
    " autocmd BufWritePost *.py call Flake8()
  augroup end " }}}
  augroup ruby_files              " {{{
      au!

      autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 textwidth=120
      autocmd filetype ruby setlocal foldmethod=syntax
  augroup end " }}}
  augroup rst_files               " {{{
    au!

    " Auto-wrap text around 74 chars
    autocmd filetype rst setlocal textwidth=74
    autocmd filetype rst setlocal formatoptions+=nqt
    autocmd filetype rst match ErrorMsg '\%>74v.\+'
  augroup end " }}}
  augroup css_group_files         " {{{
    au!

    autocmd BufNewFile,BufRead *.less setlocal filetype=less
    autocmd BufNewFile,BufRead *.scss setlocal filetype=scss
    autocmd BufNewFile,BufRead *.sass setlocal filetype=sass
    autocmd filetype css,less,sass,scss setlocal foldmethod=marker foldmarker={,}
    autocmd filetype css,less,sass,scss setlocal tabstop=2 shiftwidth=2 softtabstop=2
  augroup end "}}}
  augroup javascript_group_files  " {{{
    au!

    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript

    autocmd filetype coffee,javascript setlocal listchars=trail:·,extends:#,nbsp:·
    autocmd filetype coffee,javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

    autocmd filetype coffee setlocal foldmethod=indent foldlevelstart=1
    " autocmd filetype javascript setlocal foldmethod=marker foldmarker={,}
    autocmd filetype javascript setlocal foldmethod=syntax foldlevelstart=1
    autocmd filetype javascript syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
    autocmd filetype javascript setlocal foldtext=substitute(getline(v:foldstart), '{.*', '{...}', '')

    autocmd Syntax javascript set syntax=jquery

  augroup end " }}}
  augroup textile_files           " {{{
    au!

    autocmd filetype textile setlocal tw=78 wrap

    " Render YAML front matter inside Textile documents as comments
    autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
    autocmd filetype textile highlight link frontmatter Comment
  augroup end "}}}
  augroup markdown_files          " {{{
    au!

    autocmd filetype markdown,md setlocal tw=78 wrap

    " Render YAML front matter inside Markdown documents as comments
    autocmd filetype markdown,md syntax region frontmatter start=/\%^---$/ end=/^---$/
    autocmd filetype markdown,md highlight link frontmatter Comment
  augroup end "}}}
  augroup php_files               " {{{
    au!

    autocmd BufRead *.php setlocal makeprg=php\ -l\ %
    autocmd BufRead *.ctp setlocal filetype=php
    autocmd filetype php,ctp setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
  " }}}
endif