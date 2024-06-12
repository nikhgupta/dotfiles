-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local km = function(mode, lhs, rhs, desc, opts)
  return vim.keymap.set(
    mode,
    lhs,
    rhs,
    vim.tbl_extend("force", opts or {}, {
      desc = desc,
      noremap = true,
    })
  )
end

local setup_search_for_directory = function(name, find_keys, grep_keys, directory, hidden)
  if find_keys then
    km("n", find_keys, function()
      require("telescope.builtin").find_files({
        cwd = directory,
        hidden = true,
        file_ignore_patterns = { "node_modules", ".git" },
      })
    end, "Find " .. name)
  end
  km("n", grep_keys, function()
    require("telescope.builtin").live_grep({
      cwd = directory,
      file_ignore_patterns = { "node_modules", ".git" },
      additional_args = function(opts)
        if hidden then
          return { "--hidden" }
        else
          return {}
        end
      end,
    })
  end, "Search " .. name)
end

-----------------------------------------------------------
-- Common Overrides
-----------------------------------------------------------
km("i", "jj", "<Esc>", "Quit insert mode")
km("i", "jk", "<Esc>", "Quit insert mode")
km("n", "Y", "yy", "Yank full line")

-----------------------------------------------------------
-- Window Navigation
-----------------------------------------------------------
km("n", "<C-W>m", "<C-W>999+<C-W>999>", "Maximize current split")

-----------------------------------------------------------
-- Editor: Formatting, Folding, etc.
-----------------------------------------------------------
km("v", "<leader>=", "gq", "Format visual selection", { silent = true })

-- fold levels
km("n", "z1", "<cmd>set foldlevel=1<CR>", "Fold level 1")
km("n", "z2", "<cmd>set foldlevel=2<CR>", "Fold level 2")
km("n", "z3", "<cmd>set foldlevel=3<CR>", "Fold level 3")
km("n", "z4", "<cmd>set foldlevel=4<CR>", "Fold level 4")
km("n", "z5", "<cmd>set foldlevel=5<CR>", "Fold level 5")

-----------------------------------------------------------
-- Terminals
-----------------------------------------------------------
km("n", "!o", "Yp!!$SHELL<CR>", "[TERM] Insert output of current line below")
km("v", "!", "y<esc>`<O<esc>P`[mx`]mygv!gpg -aer $EMAIL<CR>`xv`y", "[GPG] insert encrypted text for selection below")

-----------------------------------------------------------
-- Useful Enhancements
-----------------------------------------------------------
setup_search_for_directory("dotfiles", "<leader>fd", "<leader>fD", vim.env.DOTCASTLE, true)
setup_search_for_directory("dotfiles", nil, "<leader>sud", vim.env.DOTCASTLE, true)
setup_search_for_directory("dotfiles", "<leader>fl", "<leader>fL", vim.env.HOME .. "/Code/LunchBox", false)
setup_search_for_directory("dotfiles", nil, "<leader>sul", vim.env.HOME .. "/Code/LunchBox", false)

-----------------------------------------------------------
-- Fun
-----------------------------------------------------------
km("n", "<leader>no", "mzggg?G'z", "Obfuscate buffer")
