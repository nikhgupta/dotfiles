set nomodeline                  " disable mode lines (security measure)
set noexrc                      " disble per-directory .vimrc files
set secure                      " disable unsafe commands in them

" Advanced: encryption support
" TODO: revisit
" https://coderwall.com/p/hypjbg
if exists("&cryptmethod") | set cryptmethod=blowfish | endif
Plug 'jamessan/vim-gnupg'

let g:GPGPreferArmor=1
let g:GPGPreferSign=1
let g:GPGDefaultRecipients=[$EMAIL, $EMAIL_PERSONAL, $EMAIL_WORK]
