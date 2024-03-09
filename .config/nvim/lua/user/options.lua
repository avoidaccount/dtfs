-- local variables
local opt = vim.opt

vim.treesitter.language.register("bash", "zsh")

-- disable netrw in favor of nvim-file-explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disable language providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- auto indent new lines
opt.autoindent = true

-- sync nvim with the system clipboard
opt.clipboard = "unnamedplus"

-- change popup behavior
opt.completeopt = "menu,menuone,noselect"

-- hide * markup for bold and italic
opt.conceallevel = 3

-- confirm save before exiting
opt.confirm = true

-- highlight current line
opt.cursorline = true

-- control how text is auto formatted and indented
opt.formatoptions = "jcroqlnt"

-- grep formatting and use of rg instead of grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- always use the terminal cursor as default
opt.guicursor = ""

-- highlight search results
opt.hlsearch = true

-- case insensitive matching
opt.ignorecase = true

-- preview incremental substitute
opt.inccommand = "nosplit"

-- highlight search during typing
opt.incsearch = true

-- global statusline
opt.laststatus = 3

-- enable mouse mode
opt.mouse = "a"

-- display line number
opt.number = true

-- popup blend
opt.pumblend = 10

-- maximum number of entries in a popup
opt.pumheight = 10

-- enable relative line numbers
-- opt.relativenumber = true

-- lines of context
opt.scrolloff = 8

-- show matching brackets
opt.showmatch = true

-- don't ignore case with capitals
opt.smartcase = true

-- auto insert indents
opt.smartindent = true

-- spelling language
opt.spelllang = "en"

-- enable swapfile
opt.swapfile = true

-- enable true colors
opt.termguicolors = true

-- time delay for recognizing key sequences
opt.timeoutlen = 1000

-- persistent undo (see :h undo-tree)
opt.undofile = true

-- save swap file and trigger CursorHold
opt.updatetime = 200