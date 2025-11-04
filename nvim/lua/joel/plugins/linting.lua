-- File : linting.lua
-- Description : Linting configuration (robust eslint_d)

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- helper: find project root containing an ESLint config
    local function find_eslint_root(filename)
      local markers = {
        "eslint.config.js", "eslint.config.cjs", "eslint.config.mjs",
        ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json",
        "package.json",
      }
      local found = vim.fs.find(markers, { upward = true, path = filename })[1]
      if not found then return nil, nil end
      return vim.fs.dirname(found), found
    end

    -- normalize eslint_d to a table
    local eslintd = lint.linters.eslint_d
    if type(eslintd) == "function" then
      eslintd = eslintd()
      lint.linters.eslint_d = eslintd
    end

    -- run from the project root (where the config lives)
    eslintd.cwd = function(ctx)
      local root = find_eslint_root(ctx.filename)
      return root
    end

    -- prefer local node_modules/.bin/eslint_d if available
    eslintd.cmd = function(ctx)
      local root = find_eslint_root(ctx.filename)
      if root then
        local local_bin = table.concat({ root, "node_modules", ".bin", "eslint_d" }, "/")
        if vim.fn.executable(local_bin) == 1 then
          return local_bin
        end
      end
      return "eslint_d"
    end

    -- build args per-file, pass --config only if it's a real config file (not package.json)
    eslintd.args = function(ctx)
      local _, cfg = find_eslint_root(ctx.filename)
      local args = {
        "--format", "json",
        "--no-color",
        "--stdin",
        "--stdin-filename", ctx.filename,
      }
      if cfg and not cfg:match("package%.json$") then
        table.insert(args, 1, "--config")
        table.insert(args, 2, cfg)
      end
      return args
    end

    -- force no color; don't treat non-zero exit as fatal (eslint uses it for warnings)
    eslintd.env = vim.tbl_extend("force", eslintd.env or {}, { FORCE_COLOR = "0", NO_COLOR = "1" })
    eslintd.ignore_exitcode = true

    -- only run if a config exists; otherwise skip (prevents "Could not find config file" noise)
    eslintd.condition = function(ctx)
      local root = find_eslint_root(ctx.filename)
      return root ~= nil
    end

    lint.linters_by_ft = {
      javascript        = { "eslint_d" },
      typescript        = { "eslint_d" },
      javascriptreact   = { "eslint_d" },
      typescriptreact   = { "eslint_d" },
      svelte            = { "eslint_d" },
      python            = { "ruff" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint(nil, { ignore_errors = true })
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint(nil, { ignore_errors = true })
    end, { desc = "Trigger linting for current file" })
  end,
}
