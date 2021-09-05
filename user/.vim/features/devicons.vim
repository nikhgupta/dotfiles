if !g:is_macvim
  Plug 'ryanoasis/vim-devicons'
  let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:DevIconsEnableFoldersOpenClose = 1
  if g:is_mac | let g:WebDevIconsOS = 'Darwin' | endif

  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {
        \ 'vue': '', 'yml': '', 'yaml': '', 'vim': '',
        \ 'c': '∁', 'cc': '∁', 'c++': '∁', 'cp': '∁', 'cpp': '∁',
        \ 'coffee': '♨', 'erb': '', 'rabl': '', 'tasks': '',
        \ 'thor': '', 'ru': '' }

  let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {
        \ '.*README.*$': '', 'Gemfile': '', 'Rakefile': '',
        \ '\..*zshenv.*$': '', '\..*zshrc.*$': '', '\..*vimrc.*$': '', }
end
