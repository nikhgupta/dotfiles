" Plug 'tpope/vim-markdown'             " mardown | #TODO: required?
Plug 'jtratner/vim-flavored-markdown'   " Github flavored markdown syntax
Plug 'timcharper/textile.vim'           " textile markup
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_preview_options = { 'hide_yaml_meta': 1, 'content_editable': v:true }

" Specialize:  Markdown & Textile: render YAML front matter as comments
augroup yaml_front_matter
  au!
  au filetype ghmarkdown,textile syntax region frontmatter start=/\%^---$/ end=/^---$/
  au filetype ghmarkdown,textile highlight link frontmatter Comment
augroup end
