require("mason").setup()
require("mason-lspconfig").setup()

require("lspconfig").jsonls.setup({})
require("lspconfig").marksman.setup({})
require("lspconfig").taplo.setup({})
-- require("lspconfig").typos_lsp.setup({})
