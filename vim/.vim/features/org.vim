" if g:is_nvim
"   Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
"   autocmd VimEnter * call SetupNeorgPlugin()
" endif

" function! SetupNeorgPlugin()
"   lua << EOF
"   require('neorg').setup {
"     load = {
"       ["core.defaults"] = {},
"       ["core.norg.concealer"] = {},
"       ["core.keybinds"] = {
"       config = {
"         default_keybinds = true,
"         }
"       },
"     ["core.norg.dirman"] = {
"       config = {
"         workspaces = {
"           my_workspace = "~/neorg"
"           }
"         }
"       }
"     },

"     hook = function()
"         local neorg_leader = "<Leader>"
"         local neorg_callbacks = require('neorg.callbacks')
"         neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
"           keybinds.map_event_to_mode("norg", {
"             n = {
"               { "gtd", "core.norg.qol.todo_items.todo.task_done" },
"               { "gtu", "core.norg.qol.todo_items.todo.task_undone" },
"               { "gtp", "core.norg.qol.todo_items.todo.task_pending" },
"               { "<C-Space>", "core.norg.qol.todo_items.todo.task_cycle" }
"             },
"           }, { silent = true, noremap = true })
"         end)
"     end
"   }
" EOF
" endfunction
