" customize our unite matching options {{{
let bundle = neobundle#get('unite.vim')
function! bundle.hooks.on_source(bundle)
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  call unite#filters#sorter_default#use(['sorter_rank'])
  call unite#set_profile('files', 'smartcase', 1)
  call unite#custom#source('line,outline','matchers','matcher_fuzzy')
endfunction
" }}}

" customize unite's behaviour {{{
let g:unite_prompt='» '
" let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
let g:unite_data_directory='~/.vim/.cache/unite'
call EnsureExists("~/.vim/.cache/unite")
" }}}

" customize unite's searching behaviour {{{
if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
  let g:unite_source_grep_recursive_opt=''
elseif executable('ack')
  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts='--no-heading --no-color -a -C4'
  let g:unite_source_grep_recursive_opt=''
endif
" }}}

" make unite exit itself on specified keys in normal mode {{{
function! s:unite_settings()
  nmap <buffer> Q <plug>(unite_exit)
  nmap <buffer> <esc> <plug>(unite_exit)
endfunction
autocmd FileType unite call s:unite_settings()
" }}}

" unite related bundles {{{
  NeoBundleLazy 'tsukkee/unite-help', {'autoload':{'unite_sources':'help'}}
  NeoBundleLazy 'osyo-manga/unite-filetype', { 'autoload' : {'unite_sources' : 'filetype', }}
  NeoBundleLazy 'thinca/vim-unite-history', { 'autoload' : { 'unite_sources' : ['history/command', 'history/search']}}
  NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}}
  NeoBundleLazy 'tsukkee/unite-tag', {'autoload':{'unite_sources':['tag','tag/file']}}
  NeoBundleLazy 'tacroe/unite-mark', {'autoload':{'unite_sources':'mark'}}
  NeoBundleLazy 'osyo-manga/unite-airline_themes', {'autoload':{'unite_sources':'airline_themes'}}
  NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload':{'unite_sources': 'colorscheme'}}
  NeoBundleLazy 'Shougo/junkfile.vim', {'autoload':{'commands':'JunkfileOpen', 'unite_sources':['junkfile','junkfile/new']}}
  call EnsureExists("~/.vim/.cache/junk")
  let g:junkfile#directory=expand("~/.vim/.cache/junk")
" }}}

" unite related bundles that perform in stranger ways {{{
  " NeoBundleLazy 'osyo-manga/unite-fold', {'autoload':{'unite_sources':'fold'}}
  " NeoBundleLazy 'Shougo/unite-session', {'autoload':{'unite_sources':'session', 'commands' : ['UniteSessionSave', 'UniteSessionLoad']}}
  " NeoBundleLazy 'ujihisa/unite-locate', {'autoload':{'unite_sources':'locate'}}
  " NeoBundleLazy 'osyo-manga/unite-quickfix', {'autoload':{'unite_sources': ['quickfix', 'location_list']}}
" }}}

" key mappings for unite {{{
nnoremap [unite] <nop>
nmap <leader>u [unite]

nnoremap <silent> [unite]/  :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
nnoremap <silent> [unite]b  :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]k  :<C-u>Unite -start-insert -auto-resize -buffer-name=mappings mapping<cr>
nnoremap <silent> [unite]l  :<C-u>Unite -start-insert -auto-resize -buffer-name=line line<cr>
nnoremap <silent> [unite]r  :<C-u>Unite -buffer-name=resume resume<cr>
nnoremap <silent> [unite]s  :<C-u>Unite -quick-match buffer<cr>
nnoremap <silent> [unite]y  :<C-u>Unite -buffer-name=yanks history/yank<cr>

if g:is_windows
  nnoremap <silent> [unite]u :<C-u>Unite -toggle -start-insert -auto-resize -buffer-name=mixed file_rec buffer file_mru bookmark<cr><c-u>
  nnoremap <silent> [unite]f :<C-u>Unite -toggle -start-insert -auto-resize -buffer-name=files file_rec<cr><c-u>
else
  nnoremap <silent> [unite]u :<C-u>Unite -toggle -start-insert -auto-resize -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr><c-u>
  nnoremap <silent> [unite]f :<C-u>Unite -toggle -start-insert -auto-resize -buffer-name=files file_rec/async<cr><c-u>
endif
" }}}

" plugin related mappings - sorted alphabetically {{{
" already used maps: /, b, f, k, l, r, s, u, y
nnoremap <silent> [unite]a  :<C-u>Unite -winheight=10 -auto-preview -buffer-name=airline_themes airline_themes<cr>
nnoremap <silent> [unite]c  :<C-u>Unite -auto-resize -buffer-name=commands history/command history/search<cr>
nnoremap <silent> [unite]cs :<C-u>Unite -winheight=10 -auto-preview -buffer-name=colorschemes colorscheme<cr>
nnoremap <silent> [unite]ft :<C-u>Unite -start-insert -auto-resize -buffer-name=filetypes filetype<cr>
nnoremap <silent> [unite]h  :<C-u>Unite -start-insert -auto-resize -buffer-name=help help<cr>
nnoremap <silent> [unite]j  :<C-u>Unite -auto-resize -buffer-name=junk junkfile junkfile/new<cr>
nnoremap <silent> [unite]n  :<C-u>Unite -auto-resize -buffer-name=bundles neobundle<cr>
nnoremap <silent> [unite]m  :<C-u>Unite -auto-resize -buffer-name=marks mark<cr>
nnoremap <silent> [unite]o  :<C-u>Unite -auto-resize -buffer-name=outline outline<cr>
nnoremap <silent> [unite]t  :<C-u>Unite -auto-resize -buffer-name=tags tag tag/file<cr>
" }}}

" list of unite related key mappings -- sorted alphabetically {{{
  "     /     :     search for a given pattern
  "     a     :     list available airline themes and allow auto-preview
  "     b     :     list all available buffers
  "     c     :     list commands and searches from vim's history
  "     cs    :     list available colorschemes and allow auto-preview
  "     f     :     open files recursively
  "     ft    :     list available filetypes and allow setting it for current buffer
  "     h     :     search vim's help for a particular word
  "     j     :     list available junk files and allow creating a new one
  "     k     :     list all available mappings
  "     l     :     list lines in the current buffer
  "     m     :     list available marks for current session
  "     n     :     list all available bundles on this machine
  "     o     :     outline the current buffer
  "     r     :     list available unite windows
  "     s     :     quick open a given buffer
  "     t     :     list available tags and tag-files
  "     u     :     open bookmarks, recent files and other files (recursively)
  "     y     :     list available clipboard contents
" }}}

augroup vimrc
  autocmd FileType unite call s:unite_my_settings()
augroup END"
function! s:unite_my_settings()
  " nmap <buffer> <ESC> <Plug>(unite_exit)
  " imap <buffer> jj <Plug>(unite_insert_leave)
  " imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " nnoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  " inoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  " nnoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  " inoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  " nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  " inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  " nnoremap <silent><buffer><expr> e unite#smart_map('e', unite#do_action('open'))
  " inoremap <silent><buffer><expr> e unite#smart_map('e', unite#do_action('open'))
endfunction
