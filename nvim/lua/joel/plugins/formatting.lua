-- File : formatting.lua
-- Description : Plugin for formatting text

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				vim = { "vimfaker" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				prisma = { "prisma_fmt" },
				python = { "isort", "black" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				dockerfile = { "dockerfile_fmt" },
				dockerignore = { "dockerfile_fmt" },
				toml = { "taplo" },
				sql = { "sqlfluff" },
				c = {},
				cpp = {},
				h = {},
				hpp = {},
				cs = {},
				cmake = {},
				make = {},
				["_"] = {},
			},

			-- format_on_save = {
			--   lsp_fallback = true, -- triggers clangd/omnisharp formatting
			--   async = false,
			--   timeout_ms = 1000,
			-- },
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (visual mode)" })
	end,
}
