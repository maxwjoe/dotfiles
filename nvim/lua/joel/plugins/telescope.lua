-- File : telescope.lua
-- Description : Project Fuzzy Finder 

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      -- Windows: explicitly use Ninja + clang since cmake can't auto-detect a generator without MSVC
      build = vim.fn.has("win32") == 1
        and "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=clang -G Ninja"
          .. " && cmake --build build --config Release"
          .. " && cmake --install build --prefix build"
        or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release"
          .. " && cmake --build build --config Release"
          .. " && cmake --install build --prefix build",
    },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "folke/trouble.nvim",
  },
  config = function()

    local telescope = require("telescope")
    local actions = require("telescope.actions")

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, 
            ["<C-j>"] = actions.move_selection_next, 
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
    })

    -- fzf-native requires a compiled C binary; gracefully degrade if build failed (e.g. missing compiler)
    if not pcall(telescope.load_extension, "fzf") then
      vim.notify("telescope-fzf-native not loaded (build may have failed)", vim.log.levels.WARN)
    end

    -- Keymaps 
    
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find Todos" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find Keymaps" })
    keymap.set("n", "<leader>fu", "<cmd>Telescope lsp_document_symbols symbols=class,interface,struct,enum,function,method,module<CR>", { desc = "Find useful symbols" })
  end,
}
