Plug 'vim-test/vim-test'
let test#strategy = "vimterminal"

let g:which_key_map.c.e.t = { 'name' : '+ExecuteTests' }
let g:which_key_map.c.e.t.n = 'Run nearest test case'
let g:which_key_map.c.e.t.f = 'Run tests in current file'
let g:which_key_map.c.e.t.s = 'Run entire test suite'
let g:which_key_map.c.e.t.l = 'Re-run last test'
let g:which_key_map.c.e.t.v = 'Visit file for last test'

nmap <leader>cetn :TestNearest<CR>
nmap <leader>cetf :TestFile<CR>
nmap <leader>cets :TestSuite<CR>
nmap <leader>cetl :TestLast<CR>
nmap <leader>cetv :TestVisit<CR>
