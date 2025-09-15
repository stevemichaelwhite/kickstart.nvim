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
    },
    {
        'mfussenegger/nvim-dap',
        recommended = true,
        desc = 'Debugging support. Requires language specific adapters to be configured. (see lang extras)',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'rcarriga/nvim-dap-ui',
            -- virtual text for the debugger
            {
                'theHamsta/nvim-dap-virtual-text',
                opts = {},
            },
            {
                'mfussenegger/nvim-dap-python',
                config = function()
                    local dap = require 'dap'
                    local dapui = require 'dapui'
                    local dap_python = require 'dap-python'

                    require('dapui').setup {}
                    require('nvim-dap-virtual-text').setup {
                        commented = true, -- Show virtual text alongside comment
                    }

                    dap_python.setup 'uv'

                    vim.fn.sign_define('DapBreakpoint', {
                        text = '',
                        texthl = 'DiagnosticSignError',
                        linehl = '',
                        numhl = '',
                    })

                    vim.fn.sign_define('DapBreakpointRejected', {
                        text = '', -- or "❌"
                        texthl = 'DiagnosticSignError',
                        linehl = '',
                        numhl = '',
                    })

                    vim.fn.sign_define('DapStopped', {
                        text = '', -- or "→"
                        texthl = 'DiagnosticSignWarn',
                        linehl = 'Visual',
                        numhl = 'DiagnosticSignWarn',
                    })

                    -- vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
                    -- vim.keymap.set('n', '<F6>', dap.continue)

                    vim.keymap.set('n', '<F6>', dap.step_over)
                    vim.keymap.set('n', '<F7>', dap.step_into)
                    vim.keymap.set('n', '<F8>', dap.step_out)
                    vim.keymap.set('n', '<F9>', dap.step_back)
                    vim.keymap.set('n', '<F10>', dap.restart)

                    dap.listeners.before.attach.dapui_config = function()
                        dapui.open()
                    end
                    dap.listeners.before.launch.dapui_config = function()
                        dapui.open()
                    end
                    dap.listeners.before.event_terminated.dapui_config = function()
                        dapui.close()
                    end
                    dap.listeners.before.event_exited.dapui_config = function()
                        dapui.close()
                    end
                end,
            },
        },
        keys = {
            {
                '<leader>b',
                function()
                    require('dap').toggle_breakpoint()
                end,
                desc = 'Toggle [B]reakpoint',
            },
            {
                '<leader>dc',
                function()
                    require('dap').continue()
                end,
                desc = '[D]AP [c]ontinue/start',
            },
            {
                '<leader>dr',
                function()
                    require('dap').run_to_cursor()
                end,
                desc = '[D]AP [r]un to cursor',
            },
            -- {
            --     '<leader>dr',
            --     function()
            --         require('dap').repl.toggle()
            --     end,
            --     desc = 'Toggle REPL',
            -- },
            -- {
            --     '<leader>ds',
            --     function()
            --         require('dap').session()
            --     end,
            --     desc = 'Session',
            -- },
            {
                '<leader>dt',
                function()
                    require('dap').terminate()
                end,
                desc = '[D]AP [T]erminate',
            },
        },
    },
}
