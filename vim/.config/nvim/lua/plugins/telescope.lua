return {
  "nvim-telescope/telescope.nvim",
  keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>si",
        function() require("telescope.builtin").builtin() end,
        desc = "Telescope Builtins",
      },
    { "<C-b>", require("telescope.builtin").buffers, "Find Buffers" },
    { "<C-p>", require("telescope.builtin").git_files, "Find Files" },
    { "<C-g>", require("telescope.builtin").live_grep, "Search by Grep" },
    { "<C-Space>", require("telescope.builtin").resume, "Resume Search" },
    { "??", LazyVim.pick("grep_string", { word_match = "-w" }), "Search Word under Cursor" },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      winblend = 0,
    },
  },
}
