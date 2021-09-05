Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" <C-p> or <D-p> to search files
let g:which_key_map['<C-p>'] = 'Find File'
let g:which_key_map['<C-b>'] = 'Find Buffer'
let g:which_key_map['<C-o>'] = 'Find Buffer'
nnoremap <silent> <C-p> :Files <C-r>=FindRootDirectory()<cr><cr>
nnoremap <silent> <C-b> :Buffers<cr>
nnoremap <silent> <C-o> :Buffers<cr>

let g:which_key_map.d.b = 'Buffers'
let g:which_key_map.d.f = 'Files'
let g:which_key_map.d.t = 'Tags with current word'
let g:which_key_map.d.u = 'Find Tag'
let g:which_key_map.d.T = 'All Tags'
let g:which_key_map.d.l = 'Lines'
let g:which_key_map.d.y = 'FileTypes'
let g:which_key_map.d.c = 'Colorschemes'
let g:which_key_map.d.g.s = 'GitFileStatus'
let g:which_key_map.d.g.f = 'GitFiles'
let g:which_key_map.d.g.c = 'Commits'
let g:which_key_map.d.g.b = 'BufferCommits'
let g:which_key_map.d.h.h = 'History'
let g:which_key_map.d.h[':'] = 'CommandHistory'
let g:which_key_map.d.h["/"] = 'SearchHistory'
nnoremap <silent> <leader>db :Buffers<cr>
nnoremap <silent> <leader>df :Files <C-r>=FindRootDirectory()<cr><cr>
nnoremap <silent> <leader>dT :Tags<cr>
nnoremap <silent> <leader>dt :FZFTags<cr>
nnoremap <silent> <leader>du :FZFTselect<space>
nnoremap <silent> <leader>dl :Lines<cr>
nnoremap <silent> <leader>dy :Filetypes<cr>
nnoremap <silent> <leader>dc :Colors<cr>
nnoremap <silent> <leader>dhh :History<cr>
nnoremap <silent> <leader>dh: :CmdHist<cr>
nnoremap <silent> <leader>dh/ :SearchHist<CR>
nnoremap <silent> <leader>dgc :Commits<cr>
nnoremap <silent> <leader>dgb :BCommits<cr>
nnoremap <silent> <leader>dgs :GFiles?<cr>
nnoremap <silent> <leader>dgf :GFiles<cr>

" use faster and better tags with fzf
Plug 'zackhsi/fzf-tags'
nmap <C-]> <Plug>(fzf_tags)
noreabbrev <expr> ts getcmdtype() == ":" && getcmdline() == 'ts' ? 'FZFTselect' : 'ts'

" quick search for words across project
map ? :Rg<space>
map ?? :RG<space>

" quick search for words under cursor
map <silent> * :RG <C-r>=expand("<cword>")<CR><CR>
xnoremap  * :<C-u>call VisualRipgrepSearch()<CR>:<C-u>RG <C-R>=@/<CR><CR>

" function to place selected text in search register
function! VisualRipgrepSearch()
  let temp = @f
  norm! gv"fygv
  let @/ = substitute(@f, '\n', '\\n', 'g')
  let @f = temp
endfunction

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <expr> <c-x><c-g> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

" Better command and search history
command! CmdHist call fzf#vim#command_history()
command! SearchHist call fzf#vim#search_history()

" better searches
command! -bang -nargs=* Ack call fzf#vim#ag(<q-args>, {'options': '--no-color'})

command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number -- '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'dir': FindRootDirectory()}), <bang>0)

command! -bang -nargs=* RG
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --hidden --multiline --color=always --smart-case -g "!{.git,node_modules,vendor}/*" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'dir': FindRootDirectory()}), <bang>0)

" open FZF in a bottom split
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:fzf_layout = { 'down': '40%' }
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:fzf_history_dir = '~/.vim/tmp/fzf-history'

let g:fzf_action =
      \ { 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Statement'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
