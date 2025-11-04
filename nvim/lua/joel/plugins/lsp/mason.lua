-- File : mason.lua
-- Description : LSP Manager Configuration

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
      registries = {
        'github:Crashdummyy/mason-registry',
        'github:mason-org/mason-registry',
      },
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {

				-- Vim

				"lua_ls", -- lua
				"vimls", -- vim / vimscript

				-- Documentation

				"marksman", -- markdown/markdown_inline

				-- Web Development

				"jsonls", -- json
				"vtsls", -- javascript, typescript, tsx (better TS server)
				"yamlls", -- yaml
				"html", -- html
				"cssls", -- css
				"graphql", -- graphql
				"dockerls", -- dockerfile
				"docker_compose_language_service", -- docker-compose (optional)
				"bashls", -- bash/sh

				-- Mid Level

				-- "omnisharp", -- c# (USE ROSLYN PLUGIN)
				"pyright", -- python
				"taplo", -- toml

				-- Lower Level

				"clangd", -- c/cpp
				"cmake", -- cmake
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"ruff",
				"eslint_d",
			},
		})
	end,
}
