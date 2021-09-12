" has support for code folding (default: based on indentation)
set nofoldenable                " do not enable folding, by default
set foldcolumn=0                " add a fold column to the left of line-numbers
set foldlevel=0                 " folds with a higher level will be closed
set foldlevelstart=10           " start out with everything open
set foldmethod=indent           " create folds based on indentation
set foldnestmax=7               " deepest fold is 7 levels
set foldminlines=1              " do not fold single lines, fold everything else
" which commands trigger auto-unfold
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
