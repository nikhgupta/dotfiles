Plug 'vim-test/vim-test'
let test#strategy = "vimterminal"

let g:which_key_map.c.e.t = { 'name' : '+ExecuteTests' }
let g:which_key_map.c.e.t.n = 'Run nearest test case'
let g:which_key_map.c.e.t.f = 'Run tests in current file'
let g:which_key_map.c.e.t.s = 'Run entire test suite'
let g:which_key_map.c.e.t.l = 'Re-run last test'
let g:which_key_map.c.e.t.v = 'Visit file for last test'

nmap <leader>petn :TestNearest<CR>
nmap <leader>petf :TestFile<CR>
nmap <leader>pets :TestSuite<CR>
nmap <leader>petl :TestLast<CR>
nmap <leader>petv :TestVisit<CR>

