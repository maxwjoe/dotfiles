-- File : auto-session.lua
-- Description : Plugin for session memory and restoration 

return {
  "rmagatti/auto-session",
  config = function()

    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })

    -- Keymaps
    
    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" }) 
    keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for auto session root dir" }) 

  end
}
