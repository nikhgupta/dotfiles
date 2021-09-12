" make vim secure by default
set nomodeline                  " disable mode lines (security measure)
set noexrc                      " disble per-directory .vimrc files
set secure                      " disable unsafe commands in them

" encryption support
Plug 'jamessan/vim-gnupg'
let g:GPGPreferArmor=1
let g:GPGPreferSign=1
let g:GPGDefaultRecipients=[$EMAIL, $EMAIL_PERSONAL, $EMAIL_WORK]
if exists("&cryptmethod") | set cryptmethod=blowfish | endif
