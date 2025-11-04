-- File : which-key.lua
-- Description : Plugin configuration for key hints on Leader key delay
-- Note : This is why adding descriptions for keymaps is important!

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
  
  },
}
