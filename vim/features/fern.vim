" nerdtree alternative
Plug 'lambdalisue/fern.vim'
if g:is_nvim | Plug 'antoinemadec/FixCursorHold.nvim' | endif
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-git-status.vim'

let g:cursorhold_updatetime = 100
let g:fern#renderer = "nerdfont"

" mappings
let g:which_key_map.t.u.n = 'toggle file browser'
nnoremap <silent> <leader>tun :Fern . -drawer -wait -width=30 -keep<CR>


let g:which_key_map.f.f.t = 'find file in file browser'
nnoremap <silent> ff :Fern <C-r>=FindRootDirectoryWithGit()<CR> -drawer -wait -width=30 -keep -reveal=%<CR>
nmap <silent> <leader>fft ff

augroup my-glyph-palette
  autocmd! *
  autocmd FileType nerdtree,startify call glyph_palette#apply()
  autocmd FileType fern call glyph_palette#apply() | call <SID>CustomInitFern()
augroup END

function! s:CustomInitFern() abort
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> i <Plug>(fern-action-open:split)
  nmap <buffer> s <Plug>(fern-action-open:vsplit)
  nmap <buffer> u <Plug>(fern-action-leave)
  nmap <buffer> q :<C-u>quit<CR>
  nmap <buffer> r qff
  nmap <buffer> 6 ^

  nnoremap <buffer> <C-h> <C-w>h
  nnoremap <buffer> <C-j> <C-w>j
  nnoremap <buffer> <C-k> <C-w>k
  nnoremap <buffer> <C-l> <C-w>l

  " Find and enter project root
  nnoremap <buffer><silent>
        \ <Plug>(fern-my-enter-project-root)
        \ :<C-u>call fern#helper#call(funcref('<SID>map_enter_project_root'))<CR>
  nmap <buffer><expr><silent> ^ fern#smart#scheme("^", { 'file': "\<Plug>(fern-my-enter-project-root)" })

    " Open bookmark:///
  nnoremap <buffer><silent> <Plug>(fern-my-enter-bookmark) :<C-u>Fern bookmark:///<CR>
  nmap <buffer><expr><silent> b fern#smart#scheme("\<Plug>(fern-my-enter-bookmark)", { 'bookmark': "\<C-^>" })

  " " preview window
  " nmap <buffer><expr> <Plug>(fern-my-preview-or-nop) fern#smart#leaf("\<Plug>(fern-action-open:edit)\<C-w>p", "")
  " nmap <buffer><expr> j fern#smart#drawer("j\<Plug>(fern-my-preview-or-nop)", j")
  " nmap <buffer><expr> k fern#smart#drawer("k\<Plug>(fern-my-preview-or-nop)", k")

  " remove line numbers
  setl nonumber
endfunction

function! s:map_enter_project_root(helper) abort
  " NOTE: require 'file' scheme
  let root = a:helper.sync.get_root_node()
  let path = root._path
  let path = finddir('.git/..', path . ';')
  execute printf('Fern %s', fnameescape(path))
endfunction

augroup fern_fix_git_status_colors
  au!
  autocmd ColorScheme * hi! link FernRootText SpecialComment
  autocmd ColorScheme * hi! link FernGitStatusBracket Comment
  autocmd ColorScheme * hi! link FernGitStatusIgnored Comment
  autocmd ColorScheme * hi! link FernGitStatusUntracked Comment
  autocmd ColorScheme * hi FernGitStatusIndex cterm=bold gui=bold ctermfg=2 guifg=#A3BE8C
  autocmd ColorScheme * hi FernGitStatusWorktree cterm=bold gui=bold ctermfg=1 guifg=#BF616A
  autocmd ColorScheme * hi FernGitStatusUnmerged cterm=bold gui=bold ctermfg=3 guifg=#EBCB8B
augroup end
