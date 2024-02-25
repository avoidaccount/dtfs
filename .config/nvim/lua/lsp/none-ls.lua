local none = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local async_formatting = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	vim.lsp.buf_request(
		bufnr,
		"textDocument/formatting",
		vim.lsp.util.make_formatting_params({}),
		function(err, res, ctx)
			if err then
				local err_msg = type(err) == "string" and err or err.message
				vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
				return
			end

			if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
				return
			end

			if res then
				local client = vim.lsp.get_client_by_id(ctx.client_id)
				vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd("silent noautocmd update")
				end)
			end
		end
	)
end

none.setup({
	sources = {
		none.builtins.code_actions.gitsigns.with({
			config = {
				filter_actions = function(title)
					return title:lower():match("blame") == nil
				end,
			},
		}),

		-- none.builtins.code_actions.proselint.with({
		-- 	extra_filetypes = {
		-- 		"norg",
		-- 	},
		-- }),

		none.builtins.diagnostics.markdownlint,

		none.builtins.diagnostics.proselint.with({
			extra_filetypes = {
				"norg",
			},
		}),

		none.builtins.diagnostics.selene,

		none.builtins.diagnostics.sqlfluff.with({
			-- dialet specify the type of sql
			extra_args = {
				"--dialect",
				"sqlite",
			},
		}),

		none.builtins.diagnostics.yamllint.with({
			extra_args = {
				"--config-data",
				"{extends: default, rules: {line-length: {max: 120}}}",
			},
		}),

		none.builtins.formatting.markdownlint,

		none.builtins.formatting.prettier.with({
			extra_args = {
				"--tab-width 4",
				"--use-tabs",
				"--quote-props consistent",
			},
		}),

		none.builtins.formatting.shellharden.with({
			extra_filetypes = {
				"zsh",
			},
		}),

		none.builtins.formatting.shfmt.with({
			extra_filetypes = {
				"zsh",
			},
		}),

		none.builtins.formatting.stylua,

		none.builtins.formatting.yamlfix.with({
			env = {
				YAMLFIX_WHITELINES = 1,
				YAMLFIX_INDENT_MAPPING = 4,
				YAMLFIX_INDENT_OFFSET = 4,
				YAMLFIX_INDENT_SEQUENCE = 4,
				YAMLFIX_quote_representation = '"',
			},
		}),

		none.builtins.hover.dictionary,
		none.builtins.hover.printenv,
	},

	debug = false,

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					async_formatting(bufnr)
				end,
			})
		end
	end,
})