local function augroup(name) return vim.api.nvim_create_augroup("lazynvim_" .. name, { clear = true }) end

local autocmd = vim.api.nvim_create_autocmd

-- check if we need to reload the file when it changed
autocmd({
	"focusgained",
	"termclose",
	"termleave",
}, {
	group = augroup("checktime"),
	command = "checktime",
})

-- highlight on yank
autocmd("textyankpost", {
	group = augroup("highlight_yank"),
	callback = function() vim.highlight.on_yank() end,
})

-- resize splits if window got resized
autocmd({ "vimresized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- go to last loc when opening a buffer
autocmd("bufreadpost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) then return end
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
	end,
})

-- close some filetypes with <q>
autocmd("filetype", {
	group = augroup("close_with_q"),
	pattern = {
		"plenarytestpopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- auto adjust telescope preview
autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function(args)
		if args.data.filetype ~= "help" then
			vim.wo.number = true
		elseif args.data.bufname:match("*.csv") then
			vim.wo.wrap = false
		end
	end,
})
