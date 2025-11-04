vim.g.mapleader = " "

local keymap = vim.keymap

-- Search and Highlight

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Selection Movement

vim.keymap.set("n", "<A-Down>", ":m .+1<CR>", { desc = "Move line down (Option + Arrow Key)" })
vim.keymap.set("n", "<A-Up>",   ":m .-2<CR>", { desc = "Move line up (Option + Arrow Key)" })

vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv", { desc = "Move selection down (Option + Arrow Key)" })
vim.keymap.set("v", "<A-Up>",   ":m '<-2<CR>gv", { desc = "Move selection up (Option + Arrow Key)" })

-- Window Management

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make window splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open a new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close the current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to the next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to the previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open the current buffer in a new tab" })
