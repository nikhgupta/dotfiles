let g:coc_node_path = '/Users/nikhgupta/.asdf/installs/nodejs/16.6.0/bin/node'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" list of the extensions to make sure are always installed
let g:coc_global_extensions = [
            \'coc-json',
            \'coc-css',
            \'coc-html',
            \'coc-tsserver',
            \'coc-eslint',
            \'coc-yaml',
            \'coc-snippets',
            \'coc-pyright',
            \'coc-prettier',
            \'coc-xml',
            \'coc-marketplace',
            \'coc-sh',
            \'coc-solargraph',
            \'coc-tailwindcss',
            \'coc-vimlsp',
            \'coc-yank',
            \]

let g:which_key_map.y.l = 'list Yank stack'
nmap <leader>yl :<C-u>CocList -A --normal yank<cr>

" check if backspace was the last key pressed
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent> <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

" Use <c-space> to trigger completion.
if g:is_nvim
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    silent! call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" " Highlight the symbol and its references when holding the cursor.
" function! ShowDocIfNoDiagnostic(timer_id)
"   if (coc#float#has_float() == 0)
"     silent! call CocActionAsync('doHover')
"   endif
" endfunction

" function! s:show_hover_doc()
"   call timer_start(500, 'ShowDocIfNoDiagnostic')
" endfunction

autocmd CursorHold * silent! call CocActionAsync('highlight')
" autocmd CursorHold * silent! call <SID>show_hover_doc()
" autocmd CursorHoldI * silent! call <SID>show_hover_doc()

" Formatting selected code.
let g:which_key_map['=']['c'] = 'format selected code'
xmap <leader>=c  <Plug>(coc-format-selected)
nmap <leader>=c  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
let g:which_key_map.d.a = 'COC Actions'
let g:which_key_map.d.d = 'COC Diagnostics'
let g:which_key_map.d.D = 'COC All Diagnostics'
let g:which_key_map.d.e = 'COC Extensions'
let g:which_key_map.d.c = 'COC Commands'
let g:which_key_map.d.o = 'COC Document Symbols'
let g:which_key_map.d.S = 'COC Project Symbols'
let g:which_key_map.d.r = 'COC Resume List'
let g:which_key_map.d.j = 'COC Next Action'
let g:which_key_map.d.k = 'COC Previous Action'
nnoremap <silent><nowait> <leader>da  :<C-u>CocList actions<cr>
nnoremap <silent><nowait> <leader>dd  :<C-u>CocList diagnostics --current-buf<cr>
nnoremap <silent><nowait> <leader>dD  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <leader>de  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <leader>dc  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <leader>do  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <leader>dS  :<C-u>CocList symbols<cr>
nnoremap <silent><nowait> <leader>dj  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <leader>dk  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <leader>dr  :<C-u>CocListResume<CR>
