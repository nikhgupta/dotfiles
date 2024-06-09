" uses a faster tty (terminal) & sets it title as per the file
set title                         " change the terminal's title
set ttyfast                       " always use a fast terminal

" easily exit out of terminal mode
tnoremap <C-w> <C-\><C-n><C-w>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
autocmd BufWinEnter,WinEnter term://* startinsert
if g:is_nvim
  autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal nocursorline
endif
au FileType fzf tunmap <Esc>

" mappings
let g:which_key_map.t.u.t = 'Toggle Terminal window'
nmap <silent> <leader>tut <Esc>:new<CR><Esc>:term<CR>
vmap <silent> <leader>tut <Esc>:new<CR><Esc>:term<CR>

let g:which_key_map['`'] = 'Open Terminal'
nmap <silent> <leader>` <leader>tut
vmap <silent> <leader>` <leader>tut

let g:which_key_map[':'] = 'Run a command in terminal'
map <leader>: <Esc>:new<CR><Esc>:term<space>

" fun with shell commands
nmap !o Yp!!
nnoremap !! !!$SHELL<CR>

" encrypted selected text with my EMAIL using GPG and paste below
vnoremap !x y<esc>`<O<esc>P`[mx`]mygv!gpg -aer $EMAIL<CR>`xv`y

" integrates with the user's login shell
" NOTE: DO NOT ENABLE INTERACTIVE SHELL OR TERMINAL VIM WILL SUSPEND ITSELF.
" NOTE: For this reason, important environment variables, rbenv initialization,
"       etc. must be placed inside ~/.zprofile, so that VIM can read them.
" if !g:is_windows
"   if !empty('$SHELL')
"     set shell=$SHELL\ -l
"   elseif executable('zsh')
"     set shell=zsh\ -l               " use a ZSH login shell
"   elseif executable('bash')
"     set shell=bash\ -l              " use a Bash login shell
"   else
"     set shell=/bin/sh
"   endif
" endif

" " sets appropriate terminal colors for the terminal
" " set appropriate terminal colors
" if &t_Co > 2 && &t_Co < 16
"   set t_Co =16
" elseif &t_Co > 16
"   set t_Co =256
" endif
