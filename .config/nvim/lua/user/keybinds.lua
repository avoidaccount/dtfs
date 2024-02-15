vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map("i", "jj", "<Esc>")
map("n", "<C-n>", ":e ")
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>x", ":x<CR>")
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
map("n", "<leader>dd", '"_dd')
map("v", "<leader>dd", '"_dd')
map("n", "x", '"_dl')
map("v", "x", '"_dl')

-- PLUGINS

-- open markdownpreview on browser (desktop only)
map("n", "gm", ":MarkdownPreviewToggle<CR>")
-- open undotree
map("n", "<leader>u", ":UndotreeToggle<CR>")
-- toggle file explorer using <leader> + tt
map("n", "<C-t>", ":NvimTreeToggle<CR>")
-- toggle trouble panel using <leader> + tr
map("n", "<C-p>", ":TroubleToggle<CR>")

-- TELESCOPE COMMANDS

map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fg", ":Telescope live_grep<CR>")
map("n", "<leader>fb", ":Telescope buffers<CR>")
map("n", "<leader>fh", ":Telescope help_tags<CR>")

-- neorg shortcuts

map("n", "<leader>n", ":Neorg<CR>")
