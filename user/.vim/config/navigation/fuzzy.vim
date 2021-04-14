if executable('fzf')
  " This is the default option:
  "   - Preview window on the right with 50% width
  "   - CTRL-/ will toggle preview window.
  " - Note that this array is passed as arguments to fzf#vim#with_preview function.
  " - To learn more about preview window options, see `--preview-window` section of `man fzf`.
  let g:fzf_preview_window = ['right:50%', 'ctrl-/']

  set rtp+=/usr/local/opt/fzf
  Plug 'junegunn/fzf.vim'

  " <C-p> or <D-p> to search files
  nnoremap <silent> <C-p> :FZF -m<cr>
  nnoremap <silent> <C-b> :Buffers<cr>
  nnoremap <silent> <C-o> :Buffers<cr>

  nnoremap <silent> <leader>fb :Buffers<cr>
  nnoremap <silent> <leader>ff :Files<cr>
  nnoremap <silent> <leader>ft :Tags<cr>
  nnoremap <silent> <leader>fh :History<cr>
  nnoremap <silent> <leader>fl :Lines<cr>
  nnoremap <silent> <leader>fgc :Commits<cr>
  nnoremap <silent> <leader>fgb :BCommits<cr>
  nnoremap <silent> <leader>fgf :GFiles<cr>
  nnoremap <silent> <leader>fft :Filetypes<cr>

  " Insert mode completion
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <expr> <c-x><c-g> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

  " Better command history with q:
  command! CmdHist call fzf#vim#command_history({'right': '40'})
  nnoremap q: :CmdHist<CR>

  " Better search history
  command! QHist call fzf#vim#search_history({'right': '40'})
  nnoremap q/ :QHist<CR>

  command! -bang -nargs=* Ack call fzf#vim#ag(<q-args>, {'down': '40%', 'options': --no-color'})

  command! -bang -nargs=* GGrep
        \ call fzf#vim#grep(
        \   'git grep --line-number -- '.shellescape(<q-args>), 0,
        \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
else
  Plug 'ctrlpvim/ctrlp.vim'
  " notes:
  "   - when CtrlP window is open:
  "   : f5 will clear the CtrlP cache (useful if you add new files during the session)
  "   : <C-f> & <C-b> will cycle between CtrlP modes
  "   : Press <c-d> to switch to filename only search instead of full path.
  "   : Press <c-r> to switch to regexp mode.
  "   : Use <c-j>, <c-k> or the arrow keys to navigate the result list.
  "   : Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
  "   : Use <c-n>, <c-p> to select the next/previous string in the prompt's history.
  "   : Use <c-y> to create a new file and its parent directories.
  "   : Use <c-z> to mark/unmark multiple files and <c-o> to open them.
  " Set no max file limit
  let g:ctrlp_max_files = 100
  " Ignore files matching the following patterns
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  " Store cache in this directory
  let g:ctrlp_cache_dir = expand("~/.vim") . "/tmp/cache/ctrlp"
  " Use ag/pt/rg in CtrlP for listing files. Lightning fast and respects .gitignore
  if executable("ag") | let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" --hidden' | endif
  if executable("pt") | let g:ctrlp_user_command = 'pt %s -l --nocolor -g "" --hidden' | endif
  if executable("rg") | let g:ctrlp_user_command = 'rg %s -l --nocolor -g "" --hidden' | endif

  " switch between buffers, easily.
  " disabling movement between buffers, because of this :)
  map <C-p> :CtrlPMRUFiles<CR>
  map <C-b> :CtrlPBuffer<CR>
  " Search from current directory instead of project root
  map <C-o> :CtrlP %:p:h<CR>
  nnoremap <leader>. :CtrlPTag<cr>
endif
