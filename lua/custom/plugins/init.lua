-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    {
        'declancm/cinnamon.nvim',
        version = '*', -- use latest release
        lazy = false,
        config = function()
            require('cinnamon').setup {
                -- Enable all provided keymaps
                keymaps = {
                    basic = true,
                    extra = true,
                },
                -- The scrolling mode
                -- `cursor`: animate cursor and window scrolling for any movement
                -- `window`: animate window scrolling ONLY when the cursor moves out of view
                options = {
                    mode = 'cursor',
                    delay = 4,
                    max_delta = {
                        -- Maximum distance for line movements before scroll
                        -- animation is skipped. Set to `false` to disable
                        line = 100,
                        -- Maximum distance for column movements before scroll
                        -- animation is skipped. Set to `false` to disable
                        column = 100,
                        -- Maximum duration for a movement (in ms). Automatically scales the
                        -- delay and step size
                        time = 400,
                    },
                    step_size = {
                        vertical = 1,
                        horizontal = 5,
                    },
                },
            }
        end,
    },
    {
        'folke/trouble.nvim',
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = 'Trouble',
        keys = {
            {
                '<leader>tt',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>tT',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>cs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>cl',
                '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
            {
                '<leader>tL',
                '<cmd>Trouble loclist toggle<cr>',
                desc = 'Location List (Trouble)',
            },
            {
                '<leader>tQ',
                '<cmd>Trouble qflist toggle<cr>',
                desc = 'Quickfix List (Trouble)',
            },
        },
    },
    {
        'benomahony/uv.nvim',
        opts = {
            picker_integration = true,
        },
    },
    {
        'jpalardy/vim-slime',
        init = function()
            vim.g.slime_target = 'zellij'
            vim.g.slime_default_config = { session_id = 'current', relative_pane = 'right' }
        end,
        -- config =
    },
    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('bufferline').setup {}
        end,
    },
    {
        'lewis6991/satellite.nvim',
        config = function()
            require('satellite').setup {
                current_only = false,
                winblend = 50,
                zindex = 40,
                excluded_filetypes = {},
                width = 2,
                handlers = {
                    cursor = {
                        enable = true,
                        -- Supports any number of symbols
                        symbols = { '⎺', '⎻', '⎼', '⎽' },
                        -- symbols = { '⎻', '⎼' }
                        -- Highlights:
                        -- - SatelliteCursor (default links to NonText
                    },
                    search = {
                        enable = true,
                        -- Highlights:
                        -- - SatelliteSearch (default links to Search)
                        -- - SatelliteSearchCurrent (default links to SearchCurrent)
                    },
                    diagnostic = {
                        enable = true,
                        signs = { '-', '=', '≡' },
                        min_severity = vim.diagnostic.severity.HINT,
                        -- Highlights:
                        -- - SatelliteDiagnosticError (default links to DiagnosticError)
                        -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
                        -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
                        -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
                    },
                    gitsigns = {
                        enable = true,
                        signs = { -- can only be a single character (multibyte is okay)
                            add = '│',
                            change = '│',
                            delete = '-',
                        },
                        -- Highlights:
                        -- SatelliteGitSignsAdd (default links to GitSignsAdd)
                        -- SatelliteGitSignsChange (default links to GitSignsChange)
                        -- SatelliteGitSignsDelete (default links to GitSignsDelete)
                    },
                    marks = {
                        enable = true,
                        show_builtins = false, -- shows the builtin marks like [ ] < >
                        key = 'm',
                        -- Highlights:
                        -- SatelliteMark (default links to Normal)
                    },
                    quickfix = {
                        signs = { '-', '=', '≡' },
                        -- Highlights:
                        -- SatelliteQuickfix (default links to WarningMsg)
                    },
                },
            }
        end,
    },
}
