" do share clipboard between editor and operating system
if g:is_nix && has('unnamedplus')
  set clipboard=unnamedplus,unnamed      " On Linux use + register for copy-paste
elseif g:is_nvim && g:is_wsl && has('unnamedplus') && executable('win32yank.exe')
  set clipboard=unnamedplus,unnamed
elseif has('unnamedplus')
  set clipboard=unnamedplus,unnamed
else
  set clipboard+=unnamed                 " On mac and Windows, use * register for copy-paste
endif

" pasting in visual mode replaces the selected text
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" allows turning on paste mode with '<F2>' key
let g:which_key_map['F2'] = 'turn on paste mode'
set pastetoggle=<F2>

" reselects text that was just selected (or pasted)
let g:which_key_map.v.p = 'reselect last pasted text'
nnoremap <leader>vp `[v`]
nnoremap gb `[v`]
