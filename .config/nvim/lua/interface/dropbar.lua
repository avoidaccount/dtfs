---@class dropbar_configs_t
require("dropbar").setup({
    general = {
        ---@type boolean|fun(buf: integer, win: integer): boolean
        enable = function(buf, win)
            return not vim.api.nvim_win_get_config(win).zindex
                and vim.bo[buf].buftype == ""
                and vim.api.nvim_buf_get_name(buf) ~= ""
                and not vim.wo[win].diff
        end,
        attach_events = {
            "OptionSet",
            "BufWinEnter",
            "BufWritePost",
        },
        -- Wait for a short time before updating the winbar, if another update
        -- request is received within this time, the previous request will be
        -- cancelled, this improves the performance when the user is holding
        -- down a key (e.g. 'j') to scroll the window, default to 0 ms
        -- If you encounter performance issues when scrolling the window, try
        -- setting this option to a number slightly larger than
        -- 1000 / key_repeat_rate
        update_interval = 0,
        update_events = {
            win = {
                "CursorMoved",
                "CursorMovedI",
                "WinEnter",
                "WinResized",
            },
            buf = {
                "BufModifiedSet",
                "FileChangedShellPost",
                "TextChanged",
                "TextChangedI",
            },
            global = {
                "DirChanged",
                "VimResized",
            },
        },
    },
    icons = {
        enable = true,
        kinds = {
            use_devicons = true,
            symbols = {
                Array = "󰅪 ",
                Boolean = " ",
                BreakStatement = "󰙧 ",
                Call = "󰃷 ",
                CaseStatement = "󱃙 ",
                Class = " ",
                Color = "󰏘 ",
                Constant = "󰏿 ",
                Constructor = " ",
                ContinueStatement = "→ ",
                Copilot = " ",
                Declaration = "󰙠 ",
                Delete = "󰩺 ",
                DoStatement = "󰑖 ",
                Enum = " ",
                EnumMember = " ",
                Event = " ",
                Field = " ",
                File = "󰈔 ",
                Folder = "󰉋 ",
                ForStatement = "󰑖 ",
                Function = "󰊕 ",
                H1Marker = "󰉫 ", -- Used by markdown treesitter parser
                H2Marker = "󰉬 ",
                H3Marker = "󰉭 ",
                H4Marker = "󰉮 ",
                H5Marker = "󰉯 ",
                H6Marker = "󰉰 ",
                Identifier = "󰀫 ",
                IfStatement = "󰇉 ",
                Interface = " ",
                Keyword = "󰌋 ",
                List = "󰅪 ",
                Log = "󰦪 ",
                Lsp = " ",
                Macro = "󰁌 ",
                MarkdownH1 = "󰉫 ", -- Used by builtin markdown source
                MarkdownH2 = "󰉬 ",
                MarkdownH3 = "󰉭 ",
                MarkdownH4 = "󰉮 ",
                MarkdownH5 = "󰉯 ",
                MarkdownH6 = "󰉰 ",
                Method = "󰆧 ",
                Module = "󰏗 ",
                Namespace = "󰅩 ",
                Null = "󰢤 ",
                Number = "󰎠 ",
                Object = "󰅩 ",
                Operator = "󰆕 ",
                Package = "󰆦 ",
                Pair = "󰅪 ",
                Property = " ",
                Reference = "󰦾 ",
                Regex = " ",
                Repeat = "󰑖 ",
                Scope = "󰅩 ",
                Snippet = "󰩫 ",
                Specifier = "󰦪 ",
                Statement = "󰅩 ",
                String = "󰉾 ",
                Struct = " ",
                SwitchStatement = "󰺟 ",
                Terminal = " ",
                Text = " ",
                Type = " ",
                TypeParameter = "󰆩 ",
                Unit = " ",
                Value = "󰎠 ",
                Variable = "󰀫 ",
                WhileStatement = "󰑖 ",
            },
        },
        ui = {
            bar = {
                separator = " ",
                extends = "…",
            },
            menu = {
                separator = " ",
                indicator = " ",
            },
        },
    },
    symbol = {
        preview = {
            ---Reorient the preview window on previewing a new symbol
            ---@param _ integer source window id, ignored
            ---@param range {start: {line: integer}, end: {line: integer}} 0-indexed
            reorient = function(_, range)
                local invisible = range["end"].line - vim.fn.line("w$") + 1
                if invisible > 0 then
                    local view = vim.fn.winsaveview()
                    view.topline = view.topline + invisible
                    vim.fn.winrestview(view)
                end
            end,
        },
        jump = {
            ---@param win integer source window id
            ---@param range {start: {line: integer}, end: {line: integer}} 0-indexed
            reorient = function(win, range)
                local view = vim.fn.winsaveview()
                local win_height = vim.api.nvim_win_get_height(win)
                local topline = range.start.line - math.floor(win_height / 4)
                if topline > view.topline and topline + win_height < vim.fn.line("$") then
                    view.topline = topline
                    vim.fn.winrestview(view)
                end
            end,
        },
    },
    bar = {
        ---@type dropbar_source_t[]|fun(buf: integer, win: integer): dropbar_source_t[]
        sources = function(buf, _)
            local sources = require("dropbar.sources")
            local utils = require("dropbar.utils")
            if vim.bo[buf].ft == "markdown" then
                return {
                    sources.path,
                    utils.source.fallback({
                        sources.treesitter,
                        sources.markdown,
                        sources.lsp,
                    }),
                }
            end
            return {
                sources.path,
                utils.source.fallback({
                    sources.lsp,
                    sources.treesitter,
                }),
            }
        end,
        padding = {
            left = 1,
            right = 1,
        },
        pick = {
            pivots = "abcdefghijklmnopqrstuvwxyz",
        },
        truncate = true,
    },
    menu = {
        -- When on, preview the symbol under the cursor on CursorMoved
        preview = true,
        -- When on, automatically set the cursor to the closest previous/next
        -- clickable component in the direction of cursor movement on CursorMoved
        quick_navigation = true,
        entry = {
            padding = {
                left = 1,
                right = 1,
            },
        },
        ---@type table<string, string|function|table<string, string|function>>
        keymaps = {
            ["<LeftMouse>"] = function()
                local menu = utils.menu.get_current()
                if not menu then
                    return
                end
                local mouse = vim.fn.getmousepos()
                if mouse.winid ~= menu.win then
                    local prev_menu = utils.menu.get({ win = mouse.winid })
                    if prev_menu and prev_menu.sub_menu then
                        prev_menu.sub_menu:close()
                    else
                        utils.menu.exec("close")
                        utils.bar.exec("update_current_context_hl")
                    end
                    if vim.api.nvim_win_is_valid(mouse.winid) then
                        vim.api.nvim_set_current_win(mouse.winid)
                    end
                    return
                end
                menu:click_at({ mouse.line, mouse.column - 1 }, nil, 1, "l")
            end,
            ["<CR>"] = function()
                local menu = utils.menu.get_current()
                if not menu then
                    return
                end
                local cursor = vim.api.nvim_win_get_cursor(menu.win)
                local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
                if component then
                    menu:click_on(component, nil, 1, "l")
                end
            end,
            ["<MouseMove>"] = function()
                local menu = utils.menu.get_current()
                if not menu then
                    return
                end
                local mouse = vim.fn.getmousepos()
                -- If mouse is not in the menu window or on the border, end preview
                -- and clear hover highlights
                if mouse.winid ~= menu.win or mouse.line <= 0 or mouse.column <= 0 then
                    -- Find the root menu
                    while menu and menu.prev_menu do
                        menu = menu.prev_menu
                    end
                    if menu then
                        menu:finish_preview(true)
                        menu:update_hover_hl()
                    end
                    return
                end
                if M.opts.menu.preview then
                    menu:preview_symbol_at({ mouse.line, mouse.column - 1 }, true)
                end
                menu:update_hover_hl({ mouse.line, mouse.column - 1 })
            end,
            i = function()
                local menu = utils.menu.get_current()
                if not menu then
                    return
                end
                menu:fuzzy_find_open()
            end,
        },
        ---@alias dropbar_menu_win_config_opts_t any|fun(menu: dropbar_menu_t):any
        ---@type table<string, dropbar_menu_win_config_opts_t>
        ---@see vim.api.nvim_open_win
        win_configs = {
            border = "none",
            style = "minimal",
            row = function(menu)
                return menu.prev_menu and menu.prev_menu.clicked_at and menu.prev_menu.clicked_at[1] - vim.fn.line("w0")
                    or 0
            end,
            ---@param menu dropbar_menu_t
            col = function(menu)
                if menu.prev_menu then
                    return menu.prev_menu._win_configs.width + (menu.prev_menu.scrollbar and 1 or 0)
                end
                local mouse = vim.fn.getmousepos()
                local bar = utils.bar.get({ win = menu.prev_win })
                if not bar then
                    return mouse.wincol
                end
                local _, range = bar:get_component_at(math.max(0, mouse.wincol - 1))
                return range and range.start or mouse.wincol
            end,
            relative = "win",
            win = function(menu)
                return menu.prev_menu and menu.prev_menu.win or vim.fn.getmousepos().winid
            end,
            height = function(menu)
                return math.max(
                    1,
                    math.min(#menu.entries, vim.go.pumheight ~= 0 and vim.go.pumheight or math.ceil(vim.go.lines / 4))
                )
            end,
            width = function(menu)
                local min_width = vim.go.pumwidth ~= 0 and vim.go.pumwidth or 8
                if vim.tbl_isempty(menu.entries) then
                    return min_width
                end
                return math.max(
                    min_width,
                    math.max(unpack(vim.tbl_map(function(entry)
                        return entry:displaywidth()
                    end, menu.entries)))
                )
            end,
        },
    },
    fzf = {
        ---@type table<string, string | fun()>
        keymaps = {
            ["<LeftMouse>"] = function()
                ---@type dropbar_menu_t
                local menu = utils.menu.get_current()
                if not menu then
                    return
                end
                local mouse = vim.fn.getmousepos()
                if not mouse then
                    return
                end
                if mouse.winid ~= menu.win then
                    local default_func = M.opts.menu.keymaps["<LeftMouse>"]
                    if type(default_func) == "function" then
                        default_func()
                    end
                    menu:fuzzy_find_close(false)
                    return
                elseif mouse.winrow > vim.api.nvim_buf_line_count(menu.buf) then
                    return
                end
                vim.api.nvim_win_set_cursor(menu.win, { mouse.line, mouse.column - 1 })
                menu:fuzzy_find_click_on_entry(function(entry)
                    return entry:get_component_at(mouse.column - 1, true)
                end)
            end,
            ["<MouseMove>"] = function()
                ---@type dropbar_menu_t
                local menu = utils.menu.get_current()
                if not menu then
                    return
                end
                local mouse = vim.fn.getmousepos()
                if not mouse then
                    return
                end
                -- If mouse is not in the menu window or on the border, end preview
                -- and clear hover highlights
                if mouse.winid ~= menu.win or mouse.line <= 0 or mouse.column <= 0 or mouse.winrow > #menu.entries then
                    -- Find the root menu
                    while menu and menu.prev_menu do
                        menu = menu.prev_menu
                    end
                    if menu then
                        menu:finish_preview(true)
                        menu:update_hover_hl()
                    end
                    return
                end
                if M.opts.menu.preview then
                    menu:preview_symbol_at({ mouse.line, mouse.column - 1 }, true)
                end
                menu:update_hover_hl({ mouse.line, mouse.column - 1 })
            end,
            ["<Esc>"] = function()
                require("dropbar.api").fuzzy_find_toggle()
            end,
            ["<Enter>"] = function()
                require("dropbar.api").fuzzy_find_click()
            end,
            ["<S-Enter>"] = function()
                require("dropbar.api").fuzzy_find_click(-1)
            end,
            ["<Up>"] = function()
                require("dropbar.api").fuzzy_find_navigate("up")
            end,
            ["<Down>"] = function()
                require("dropbar.api").fuzzy_find_navigate("down")
            end,
            ["<C-k>"] = function()
                require("dropbar.api").fuzzy_find_navigate("up")
            end,
            ["<C-j>"] = function()
                require("dropbar.api").fuzzy_find_navigate("down")
            end,
        },
        -- Options passed to `:h nvim_open_win`. The fuzzy finder will use its
        -- parent window's config by default, but options set here will override those.
        win_configs = {},
        ---@type string
        prompt = "%#htmlTag# ",
        ---@type string
        char_pattern = "[%w%p]",
        ---@type boolean
        retain_inner_spaces = true,
        ---@type boolean
        -- When opening an entry with a submenu via the fuzzy finder,
        -- open the submenu in fuzzy finder mode.
        fuzzy_find_on_click = true,
    },
    sources = {
        path = {
            ---@type string|fun(buf: integer): string
            relative_to = function(_)
                return vim.fn.getcwd()
            end,
            ---Can be used to filter out files or directories
            ---based on their name
            ---@type fun(name: string): boolean
            filter = function(_)
                return true
            end,
            ---Last symbol from path source when current buf is modified
            ---@param sym dropbar_symbol_t
            ---@return dropbar_symbol_t
            modified = function(sym)
                return sym
            end,
        },
        treesitter = {
            -- Lua pattern used to extract a short name from the node text
            name_pattern = "[#~%*%w%._%->!@:]+%s*" .. string.rep("[#~%*%w%._%->!@:]*", 3, "%s*"),
            -- The order matters! The first match is used as the type
            -- of the treesitter symbol and used to show the icon
            -- Types listed below must have corresponding icons
            -- in the `icons.kinds.symbols` table for the icon to be shown
            valid_types = {
                "array",
                "boolean",
                "break_statement",
                "call",
                "case_statement",
                "class",
                "constant",
                "constructor",
                "continue_statement",
                "delete",
                "do_statement",
                "enum",
                "enum_member",
                "event",
                "for_statement",
                "function",
                "h1_marker",
                "h2_marker",
                "h3_marker",
                "h4_marker",
                "h5_marker",
                "h6_marker",
                "if_statement",
                "interface",
                "keyword",
                "list",
                "macro",
                "method",
                "module",
                "namespace",
                "null",
                "number",
                "operator",
                "package",
                "pair",
                "property",
                "reference",
                "repeat",
                "scope",
                "specifier",
                "string",
                "struct",
                "switch_statement",
                "type",
                "type_parameter",
                "unit",
                "value",
                "variable",
                "while_statement",
                "declaration",
                "field",
                "identifier",
                "object",
                "statement",
                "text",
            },
        },
        lsp = {
            request = {
                -- Times to retry a request before giving up
                ttl_init = 60,
                interval = 1000, -- in ms
            },
        },
        markdown = {
            parse = {
                -- Number of lines to update when cursor moves out of the parsed range
                look_ahead = 200,
            },
        },
        terminal = {
            ---@type string|fun(buf: integer): string
            icon = function(buf)
                local icon = M.opts.icons.kinds.symbols.Terminal
                if M.opts.icons.kinds.use_devicons then
                    icon = require("nvim-web-devicons").get_icon_by_filetype(vim.bo[buf].filetype) or icon
                end
                return icon
            end,
            ---@type string|fun(buf: integer): string
            name = vim.api.nvim_buf_get_name,
            ---@type boolean
            ---Show the current terminal buffer in the menu
            show_current = true,
        },
    },
})
