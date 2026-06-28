-- File : colorscheme.lua
-- Description : Plugin configuration for editor Color Scheme

-- -- *** Tokyo Night ***
--
-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("tokyonight").setup({
--       style = "night",        -- "storm", "night", "moon", "day"
--       transparent = false,
--       terminal_colors = true,
--     })
--     vim.cmd.colorscheme("tokyonight")
--   end,
-- }

-- *** GITHUB ***

return {
	"projekt0n/github-nvim-theme",
	priority = 1000,
	config = function()
		vim.cmd("colorscheme github_dark_default")
	end,
}

-- *** Old School ***

-- return {
--   {
--     "L-Colombo/oldschool.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       require("oldschool").setup({
--         -- optional settings
--         transparent = false,
--         italics = false,
--       })
--       vim.cmd("colorscheme oldschool")
--     end,
--   },
-- }
