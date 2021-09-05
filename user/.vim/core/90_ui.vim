" show relative line numbers where they make sense, otherwise absolute ones
set number                      " always show line numbers
set numberwidth=4               " number of culumns for line numbers
augroup relative_line_numbers
  au!
  autocmd FocusLost,BufLeave,InsertEnter   * if &number | :setl norelativenumber | endif
  autocmd FocusGained,BufEnter,InsertLeave * if &number | :setl relativenumber   | endif
augroup end

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" Recently vim can merge signcolumn and number column into one
if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" highlight current line, but not the current column
set cursorline                  " highlight the current line for quick orientation
set nocursorcolumn              " do not highlight the current column

" highlight column markers for several columns
if has('syntax') | let &colorcolumn="+1,+21,+41,+81" | endif

" toggle RelativeLineNumbers manually using Ctrl+n
let g:which_key_map.t.e.r = 'toggle relative line numbers'
nnoremap <leader>ter :set relativenumber!<cr>

" toggle highlighting of cursor column - useful for manual indentation
let g:which_key_map.t.e.c = 'toggle cursor columns'
nnoremap <leader>tec :set cursorcolumn!<CR>

" scratchable buffer for scrappables
Plug 'duff/vim-scratch'
let g:which_key_map.t.u.s = 'open Scratch window'
nmap <leader>tus :Sscratch<CR><C-W>x<C-J>
