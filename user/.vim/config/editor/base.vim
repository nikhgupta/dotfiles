" Recommend:   minimal set of sensible configuration for the editor {{{
  set virtualedit=onemore         " allow cursor 1 char beyond end of current line
  set backspace=indent,eol,start  " allow backspacing over everything in insert mode
  set fileformats="unix,dos,mac"  " EOL that will be tried when reading buffers
" }}}
" Recommend:   uses soft tabs (with spaces) over hard tabs - as default {{{
  set tabstop=2                   " a tab is two spaces
  set softtabstop=2               " when <BS>, pretend tab is removed, even if spaces
  set expandtab                   " expand tabs, by default
  set nojoinspaces                " prevents two spaces after punctuation on join
" }}}
" Recommend:   displays invisible whitespace e.g. hard tabs {{{
  set list                        " show invisible characters like spaces
                                  " enabled later via autocmd on certain filetypes
  set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:·
" }}}
" Recommend:   wraps text automatically, when editing it {{{
  set nowrap                      " don't wrap lines
  set linebreak                   " break long lines at words, when wrap is on
  set whichwrap=b,s,h,l,<,>,[,]   " allow <BS> & cursor keys to move to prev/next line
  " set showbreak=↪
  let &showbreak="\u21aa "        " string to put at the starting of wrapped lines
  set textwidth=120               " wrap after this many characters in a line
" }}}
" Recommended: quickly get out of insert mode using 'jj' or 'jk' keys {{{
  inoremap jj <Esc>
  inoremap jk <Esc>
" }}}
" Expected:    restore cursor after joining lines {{{
  nnoremap J mjJ`j
" }}}
" Expected:    visual shifting (does not exit Visual mode when shifting text) {{{
  vnoremap < <gv
  vnoremap > >gv
" }}}
" Personalize: doesn't auto-format text (later enabled for: code comments) {{{
  " do not format just about any type of text, esp. source code
  set formatoptions-=t
  " recognize numbered lists when formatting
  set formatoptions+=n
  " don't break a line after a one-letter word
  set formatoptions+=1
" }}}
" Personalize: disables spell check, by default (enabled - for text files) {{{
  " no spell check, by default - enabled via autocommands, where required
  " `public` dictionary file is versioned, while the `private` one is not.
  if has('spell')
    set dictionary=/usr/share/dict/words
    set spellfile=~/.vim/spell/public.utf-8.add,~/.vim/spell/private.utf-8.add
    set nospell

    nnoremap zG 2zg
  endif
" }}}
" Mappings:    provides replaying a macro linewise on a visual selection {{{
  " note that, the macro must be recorded in the `v` register
  vnoremap <leader>qv :normal @v
" }}}
