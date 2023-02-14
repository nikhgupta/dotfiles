Plug 'liuchengxu/vim-which-key'
let g:which_key_map =  {}
let g:which_key_centered = 0

" reassign default Space behaviour in normal mode
nmap <Space> <nop>

let mapleader      = "\<Space>"     " change mapleader key from / to space
let g:mapleader    = "\<Space>"     " some plugins may require this variable to be set
let maplocalleader = ","           " used inside filetype settings

" key groups
let g:which_key_map.o = { 'name' : '+Open' }
let g:which_key_map.o.a = { 'name' : '+Application' }
let g:which_key_map.x = { 'name' : '+Quit' }
let g:which_key_map.x.a = { 'name' : '+QuitApplication' }

let g:which_key_map.v = { 'name' : '+VIM' }
let g:which_key_map.v.h = { 'name' : '+HelpVIM' }

let g:which_key_map.e = { 'name' : '+Execute' }
let g:which_key_map.e.b = { 'name' : '+ExecuteInBuffer' }
let g:which_key_map.e.f = { 'name' : '+ExecuteForFile' }

let g:which_key_map.c = { 'name' : '+Code' }
let g:which_key_map.c.e = { 'name' : '+CodeExecute' }

let g:which_key_map.t = { 'name' : '+Toggle' }
let g:which_key_map.t.e = { 'name' : '+ToggleEditor' }
let g:which_key_map.t.u = { 'name' : '+ToggleUI' }
let g:which_key_map.t.a = { 'name' : '+ToggleApplication' }

let g:which_key_map.f = { 'name' : '+Search' }
let g:which_key_map.f.b = { 'name' : '+SearchBuffer' }
let g:which_key_map.f.f = { 'name' : '+SearchFiles' }
let g:which_key_map.f.p = { 'name' : '+SearchProject' }

let g:which_key_map.d = { 'name' : '+SearchFuzzy' }
let g:which_key_map.d.g = { 'name' : '+SearchFuzzyGit' }
let g:which_key_map.d.h = { 'name' : '+SearchFuzzyHistory' }

let g:which_key_map.r = { 'name' : '+Replace' }
let g:which_key_map.r.b = { 'name' : '+ReplaceBuffer' }
let g:which_key_map.r.f = { 'name' : '+ReplaceFiles' }
let g:which_key_map.r.p = { 'name' : '+ReplaceProject' }

let g:which_key_map.g = { 'name' : '+Git' }
let g:which_key_map.v = { 'name' : '+Select' }
let g:which_key_map.y = { 'name' : '+Clipboard' }
let g:which_key_map.q = { 'name' : '+Macros' }
let g:which_key_map.w = { 'name' : '+Write/Save' }
let g:which_key_map.z = { 'name' : '+Fold' }
let g:which_key_map['='] = { 'name' : '+Format' }
let g:which_key_map['<C-w>'] = { 'name' : '+Window' }

nnoremap <silent> <leader>       :<c-u>WhichKey       '<Space>'<CR>
vnoremap <silent> <leader>       :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader>  :<c-u>WhichKey       ','<CR>
vnoremap <silent> <localleader>  :<c-u>WhichKeyVisual ','<CR>

let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'}
let g:which_key_hspace = 5
let g:which_key_centered = 1

" autocmd! FileType which_key
" autocmd  FileType which_key set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

augroup which_key_theme
  au!
  autocmd FileType which_key highlight WhichKey cterm=bold ctermbg=grey ctermfg=0
  autocmd FileType which_key highlight WhichKeySeperator ctermbg=grey ctermfg=darkgrey
  autocmd FileType which_key highlight WhichKeyGroup cterm=bold ctermbg=grey ctermfg=8
  autocmd FileType which_key highlight WhichKeyDesc ctermbg=grey ctermfg=8
  autocmd FileType which_key highlight WhichKeyFloating ctermbg=grey ctermfg=0
augroup end
