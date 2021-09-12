Plug 'mhinz/vim-startify'

let g:startify_bookmarks = [ '~/.vimrc', '~/.zshrc', '~/.zshenv', $DOTCASTLE ]

" do not display intro message on Vim startup
set shortmess+=I

" when opening a shortcut, switch to its directory
let g:startify_change_to_dir = 1
" enable 'empty buffer', and 'quit' commands
let g:startify_enable_special = 0
" display upto 10 recent files
let g:startify_files_number = 7
" also, allow 'o' to open an empty buffer
let g:startify_empty_buffer_key = 'o'
" change to the root repository path when opening files
let g:startify_change_to_vcs_root = 1
" use the given session directory
let g:startify_session_dir = expand("~/.vim") . "/tmp/sessions/"
" first four shortcuts should be available from home row
let g:startify_custom_indices = [ 'a', 'd', 'f', 'l', 'w', 'p' ]
" skip these files from the recent files list
let g:startify_skiplist = [ 'COMMIT_EDITMSG', $VIMRUNTIME .'/doc', 'bundle/.*/doc', '/tmp' ]

" display shortcuts in the given order
let g:startify_list_order = [
      \ ['   Your bookmarks:'], 'bookmarks',
      \ ['   Your sessions:'], 'sessions',
      \ ['   Your recently opened files (from current directory):'], 'dir',
      \ ['   Your recently opened files (all of them):'], 'files',
      \ ]

" show vim logo :)
let g:startify_custom_footer = [  '', '',
      \  '    ██╗   ██╗ ██╗ ███╗   ███╗    ',
      \  '    ██║   ██║ ██║ ████╗ ████║    ',
      \  '    ██║   ██║ ██║ ██╔████╔██║    ',
      \  '    ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║    ',
      \  '     ╚████╔╝  ██║ ██║ ╚═╝ ██║    ',
      \  '      ╚═══╝   ╚═╝ ╚═╝     ╚═╝    '  ]

" colors for startup screen
hi! default link StartifyBracket LineNr
hi! default link StartifyFile    Keyword
hi! default link StartifyFooter  String
hi! default link StartifyHeader  String
hi! default link StartifyNumber  Function
hi! default link StartifyPath    LineNr
hi! default link StartifySection Special
hi! default link StartifySelect  LineNr
hi! default link StartifySlash   LineNr
hi! default link StartifySpecial Special

" mappings and miscelleneous behaviour
let g:which_key_map.o.a.s = 'open Startify'
nnoremap <silent> <leader>oas :Startify<CR>

augroup vim_startup_screen
  au!
  au User Startified setl colorcolumn=0 buftype=
  au User Startified AirlineRefresh
  " au User Startified nnoremap <silent!> <buffer> <leader>st :e#<CR>
augroup end

