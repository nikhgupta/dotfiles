" has helper commands to run simple unix commands, like `chmod`
Plug 'tpope/vim-eunuch'
let g:which_key_map.e.f.x = 'make current file executable'
nmap <leader>efx :Chmod +x<CR>

" quickly, obfuscates the current buffer
let g:which_key_map.e.b.o = 'obfuscate current buffer'
nnoremap <leader>ebo mzggg?G'z

" has a command that shows the MD5 of the current buffer or range
let g:which_key_map.e.b.h = 'get md5 hash for current buffer'
command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5')
nnoremap <leader>ebh :MD5<CR>


