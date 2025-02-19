vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Makes cursor not jump 'over' a line if it's wrapped to.a second line
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Visual move line up / down
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Center line on screen after page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- remap q to <leader>q
vim.keymap.set("n", "<leader>q", "q", { silent = true, remap = false })
vim.keymap.set("n", "q", "<Nop>", { silent = true, remap = false })

-- make command line work with emacs style editing
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-e>", "<End>")
vim.keymap.set("c", "<M-f>", "<S-Right>")
vim.keymap.set("c", "<M-b>", "<S-Left>")

-- Put Y back for yanking
vim.keymap.set("n", "Y", "yy", { noremap = true })

-- Map za to <space> for folding/unfolding
vim.keymap.set("n", "<space>", "za")
