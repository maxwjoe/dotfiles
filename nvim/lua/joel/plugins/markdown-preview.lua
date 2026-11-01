-- File : markdown-preview.lua
-- Description : Markdown browser preview
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = "cd app && npm install",
}
