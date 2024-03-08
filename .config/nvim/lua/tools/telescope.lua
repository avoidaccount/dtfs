require("telescope").load_extension("harpoon")
require("telescope").load_extension("undo")
require("telescope").load_extension("zoxide")

vim.keymap.set("n", "<leader>cd", require("telescope").extensions.zoxide.list)

require("telescope").setup({
    defaults = {
        extensions = {
            undo = {
                mappings = {
                    i = {
                        ["<cr>"] = require("telescope-undo.actions").yank_additions,
                        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                        ["<C-cr>"] = require("telescope-undo.actions").restore,
                        -- alternative defaults, for users whose terminals do questionable things with modified <cr>
                        ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
                        ["<C-r>"] = require("telescope-undo.actions").restore,
                    },
                    n = {
                        ["y"] = require("telescope-undo.actions").yank_additions,
                        ["Y"] = require("telescope-undo.actions").yank_deletions,
                        ["u"] = require("telescope-undo.actions").restore,
                    },
                },
            },
        },

        preview = {
            mime_hook = function(filepath, bufnr, opts)
                local is_image = function(filepath)
                    local image_extensions = { "png", "jpg" } -- Supported image formats
                    local split_path = vim.split(filepath:lower(), ".", { plain = true })
                    local extension = split_path[#split_path]
                    return vim.tbl_contains(image_extensions, extension)
                end
                if is_image(filepath) then
                    local term = vim.api.nvim_open_term(bufnr, {})
                    local function send_output(_, data, _)
                        for _, d in ipairs(data) do
                            vim.api.nvim_chan_send(term, d .. "\r\n")
                        end
                    end
                    vim.fn.jobstart({
                        "w3m-img",
                        filepath, -- Terminal image viewer command
                    }, { on_stdout = send_output, stdout_buffered = true, pty = true })
                else
                    require("telescope.previewers.utils").set_preview_message(
                        bufnr,
                        opts.winid,
                        "Binary cannot be previewed"
                    )
                end
            end,
        },
    },

    pickers = {
        find_files = {
            dotfiles = true,
            theme = "ivy",
        },
    },
})