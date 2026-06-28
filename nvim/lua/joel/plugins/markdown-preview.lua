-- File : markdown-preview.lua
-- Description : Markdown browser preview
return {
  "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  ft = "markdown",
  config = function()
  end,
}
