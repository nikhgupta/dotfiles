return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        rubocop = {},
        solargraph = {},
        volar = {},
      },
    },
  },
  { import = "lazyvim.plugins.extras.lang.typescript" },
}
