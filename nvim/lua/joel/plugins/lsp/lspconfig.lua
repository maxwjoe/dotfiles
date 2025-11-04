-- File : lspconfig.lua
-- Description : LSP Configuration

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/lazydev.nvim", opts = {} },
  },
  config = function()

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)

        -- Buffer local mappings.
        local opts = { buffer = ev.buf, silent = true }

        -- helper
        local function map_key(mode, keys, func, desc)
          opts.desc = desc
          keymap.set(mode, keys, func, opts)
        end

        -------------------------------------------------------------------------
        -- Jump/Show pattern:
        -- lowercase = jump immediately
        -- UPPERCASE = Telescope picker
        -------------------------------------------------------------------------

        -- Definitions
        map_key("n", "gd", vim.lsp.buf.definition,               "Jump to definition")
        map_key("n", "gD", "<cmd>Telescope lsp_definitions<CR>", "Show definitions")

        -- References
        map_key("n", "gr", vim.lsp.buf.references,               "Jump to references")
        map_key("n", "gR", "<cmd>Telescope lsp_references<CR>",  "Show references")

        -- Implementations
        map_key("n", "gi", vim.lsp.buf.implementation,                "Jump to implementation")
        map_key("n", "gI", "<cmd>Telescope lsp_implementations<CR>",  "Show implementations")

        -- Type definitions
        map_key("n", "gt", vim.lsp.buf.type_definition,               "Jump to type definition")
        map_key("n", "gT", "<cmd>Telescope lsp_type_definitions<CR>", "Show type definitions")

        -------------------------------------------------------------------------
        -- Utility
        -------------------------------------------------------------------------

        map_key({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,     "Code action")
        map_key("n", "<leader>rn", vim.lsp.buf.rename,                   "Rename symbol")
        map_key("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer diagnostics")
        map_key("n", "<leader>d", vim.diagnostic.open_float,             "Line diagnostics")

        map_key("n", "[d", function()
          vim.diagnostic.jump({ count = 1, float = true })
        end, "Prev diagnostic")

        map_key("n", "]d", function()
          vim.diagnostic.jump({ count = -1, float = true })
        end, "Next diagnostic")

        map_key("n", "K",  vim.lsp.buf.hover,                             "Hover docs")
        map_key("n", "<leader>rs", ":LspRestart<CR>",                     "Restart LSP")
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()
    capabilities.offsetEncoding = { "utf-16" }

    local severity = vim.diagnostic.severity

    vim.diagnostic.config({
      signs = {
        text = {
          [severity.ERROR] = " ",
          [severity.WARN]  = " ",
          [severity.HINT]  = "󰠠 ",
          [severity.INFO]  = " ",
        },
      },
    })

    vim.lsp.inlay_hint.enable()

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

	-- Custom Configurations Here

  end,
}
