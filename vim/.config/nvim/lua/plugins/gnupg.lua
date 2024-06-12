return {
  {
    "jamessan/vim-gnupg",
    config = function()
      -- encryption support
      vim.g.GPGPreferSign = 1
      vim.g.GPGPreferArmor = 1
      vim.g.GPGDefaultRecipients = {
        os.getenv("EMAIL"),
        os.getenv("EMAIL_PERSONAL"),
        os.getenv("EMAIL_WORK"),
      }
      if vim.fn.exists("&cryptmethod") == 1 then
        vim.opt.cryptmethod = "blowfish"
      end
    end,
  },
}
