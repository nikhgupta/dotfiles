return {
  {
    "tpope/vim-fugitive",
    cmd = "G",
    lazy = false,
  },
  { "tpope/vim-rhubarb", lazy = false },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    init = function()
      require("neogit").setup({})
    end,
    config = function()
      vim.keymap.set("n", "<leader>gn", "<cmd>Neogit<cr>", { desc = "Open NeoGit" })
    end,
  },
}
