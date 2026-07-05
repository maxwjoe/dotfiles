-- File : treesitter.lua
-- Description : Plugin for parsing and building the Syntax Tree

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
    },
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup({
          opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = false,
          },
        })
      end,
    },
  },

  config = function()
    local ts = require("nvim-treesitter")
    -- Guard: install() only exists on the main branch; skip on master (pre-:Lazy sync)
    if not ts.install then return end

    ts.install({
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "markdown",
      "markdown_inline",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "query",
      "vimdoc",
      "c",
      "c_sharp",
      "sql",
      "cpp",
      "python",
      "cmake",
      "make",
      "toml",
    })

    -- Enable treesitter highlighting + indentation for all filetypes with a parser
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function(args)
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    vim.treesitter.language.register("bash", "zsh")

    -- Textobject setup
    require("nvim-treesitter-textobjects").setup({
      select = { lookahead = true },
      move = { set_jumps = true },
    })

    -- Select keymaps
    vim.keymap.set({ "x", "o" }, "af", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "if", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ac", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ic", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
    end)

    -- Move keymaps
    vim.keymap.set({ "n", "x", "o" }, "]m", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]]", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[m", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[[", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
    end)
  end,
}
