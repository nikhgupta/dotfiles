return {
  -- // CODING
  { import = "lazyvim.plugins.extras.coding.copilot" }, -- copilot ai
  { import = "lazyvim.plugins.extras.coding.copilot-chat" }, --copilot ai chat
  { import = "lazyvim.plugins.extras.coding.luasnip" }, -- snippets
  { import = "lazyvim.plugins.extras.coding.mini-comment" }, -- comment toggler
  { import = "lazyvim.plugins.extras.coding.neogen" }, -- annotation generator
  -- { import = "lazyvim.plugins.extras.coding.codeium" }, -- codeium ai

  -- // LANGUAGES
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.ruby" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.sql" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.vue" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
  -- { import = "lazyvim.plugins.extras.lang.svelte" },

  -- // UI / ENHANCEMENTS
  { import = "lazyvim.plugins.extras.coding.yanky" }, -- better yanking
  { import = "lazyvim.plugins.extras.editor.aerial" }, -- code outline
  { import = "lazyvim.plugins.extras.editor.harpoon2" }, -- quick move to file in project
  { import = "lazyvim.plugins.extras.util.octo" }, -- github management
  { import = "lazyvim.plugins.extras.util.project" }, -- projects management
  -- { import = "lazyvim.plugins.extras.editor.leap" },
  -- { import = "lazyvim.plugins.extras.editor.mini-move" },

  { import = "lazyvim.plugins.extras.lsp.none-ls" },

  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    opts = {
      manual_mode = false, -- automactically add
      detection_methods = { "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".source_me.zsh" },
    },
  },
}
