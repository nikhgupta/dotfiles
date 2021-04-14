Plug 'Keithbsmiley/investigate.vim'
map K :call investigate#Investigate()<CR><CR>

let g:investigate_use_dash=1
" NOTE: This does not work at the moment, as 'open' encodes the URL wrongly.
" map docs for the following languages to http://devdocs.io
" for fs in [ 'c', 'cpp', 'css', 'django', 'go', 'haskell', 'html',
"           \ 'javascript', 'php', 'python', 'ruby', 'rails' ]
"   execute( 'let g:investigate_url_for_'.fs.'="http://devdocs.io/#q='.fs.' ^s"')
" endfor
" let g:investigate_url_for_coffee = 'http://devdocs.io/#q=coffeescript ^s'

augroup documentor
  au!

  " appropriately use rails docs when inside a rails buffer
  au User Rails silent! let g:investigate_syntax_for_ruby="rails"
  au BufLeave *.rb silent! let g:investigate_syntax_for_ruby="ruby"

  " vim has additional help available via 'gK' mapping
  au filetype vim silent! nmap gK :let g:investigate_use_url_for_vim = 1<CR>
        \ :call investigate#Investigate()<CR><CR>
        \ :let g:investigate_use_url_for_vim = 0<CR>
augroup end
