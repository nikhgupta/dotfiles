" Expedite:    has helper commands to run simple unix commands, like `chmod` {{{
  Plug 'tpope/vim-eunuch'
" }}}
" Component:   scratchable buffer for scrappables {{{
  Plug 'duff/vim-scratch'
  nmap <leader><tab> :Sscratch<CR><C-W>x<C-J>
" }}}
" Mappings:    quickly, obfuscates the current buffer {{{
  nnoremap <F9> mzggg?G'z
" }}}
" Specialize:  has a command that shows the MD5 of the current buffer or range {{{
  command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5')
" }}}
