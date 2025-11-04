-- File : diffview.lua
-- Description : Plugin for viewing git diffs in Neovim

return {
  'sindrets/diffview.nvim',
  config = function()
    -- Toggle function
    local function toggle_diffview()
      local view = require('diffview.lib').get_current_view()
      if view then
        vim.cmd('DiffviewClose')
      else
        vim.cmd('DiffviewOpen')
      end
    end
    
    vim.keymap.set('n', '<leader>df', toggle_diffview, { desc = 'Toggle Diff View' })
  end
}
