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
        config = function(_, opts)
            local dap = require 'dap'
            local dap_python = require 'dap-python'

            -- setup with your preferred python interpreter
            dap_python.setup 'python'

            -- add/override python configurations
            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = 'Debug (justMyCode = false)',
                    program = '${file}', -- debug current file
                    justMyCode = false, -- 👈 step into library code
                    console = 'integratedTerminal',
                },
            }
        end,
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
    -- {
    --     'nvim-tree/nvim-tree.lua',
    --     version = '*',
    --     lazy = false,
    --     dependencies = {
    --         { 'nvim-tree/nvim-web-devicons', opts = {}, lazy = false },
    --     },
    --     config = function()
    --         require('nvim-tree').setup {}
    --     end,
    --     keys = {
    --         -- Toggle tree with <C-n>
    --         { '<C-n>', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle NvimTree' },
    --
    --         -- Focus tree with <leader>e
    --         { '<leader>e', '<cmd>NvimTreeFocus<cr>', desc = 'Focus NvimTree' },
    --     },
    -- },
    {
        '3rd/image.nvim',
        event = 'VeryLazy',
        opts = {
            backend = 'kitty',
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { 'norg' },
                },
            },
            max_width = 100,
            max_height = 12,
            max_width_window_percentage = math.huge,
            max_height_window_percentage = math.huge,
            window_overlap_clear_enabled = true,
            window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
            kitty_method = 'normal',
        },
    },
    {
        'benlubas/molten-nvim',
        version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
        build = ':UpdateRemotePlugins',
        init = function()
            -- this is an example, not a default. Please see the readme for more configuration options
            vim.g.molten_output_win_max_height = 12
            vim.g.molten_auto_open_output = false

            -- this guide will be using image.nvim
            -- Don't forget to setup and install the plugin if you want to view image outputs
            vim.g.molten_image_provider = 'image.nvim'

            -- optional, I like wrapping. works for virt text and the output window
            vim.g.molten_wrap_output = true

            -- Output as virtual text. Allows outputs to always be shown, works with images, but can
            -- be buggy with longer images
            vim.g.molten_virt_text_output = true

            -- this will make it so the output shows up below the \`\`\` cell delimiter
            vim.g.molten_virt_lines_off_by_1 = true
        end,
        config = function()
            vim.keymap.set('n', '<localleader>e', ':MoltenEvaluateOperator<CR>', { desc = 'evaluate operator', silent = true })
            vim.keymap.set('n', '<localleader>os', ':noautocmd MoltenEnterOutput<CR>', { desc = 'open output window', silent = true })
        end,
    },
    {
        'quarto-dev/quarto-nvim',
        dependencies = {
            {
                'jmbuhr/otter.nvim',
                dependencies = {
                    'nvim-treesitter/nvim-treesitter',
                },
                config = function(_, opts)
                    local otter = require 'otter'
                    otter.setup(opts)

                    -- Override K only for qmd buffers
                    vim.api.nvim_create_autocmd('FileType', {
                        pattern = 'quarto',
                        callback = function(args)
                            local buf = args.buf
                            vim.keymap.set('n', 'K', function()
                                local client0 = vim.lsp.get_clients({ bufnr = buf })[1]
                                ---@class OtterTextDocumentPositionParams: lsp.TextDocumentPositionParams
                                ---@field otter table|nil
                                local params = vim.lsp.util.make_position_params(0, client0 and client0.offset_encoding or 'utf-16')
                                -- local params = vim.lsp.util.make_position_params()
                                params.otter = { lang = 'python' } -- force forward hover to basedpyright
                                vim.lsp.buf_request(buf, 'textDocument/hover', params, vim.lsp.handlers.hover)
                            end, { buffer = buf, desc = 'Hover (force Python via otter)' })
                        end,
                    })
                end,
                -- opts = { lsp = { hover = true } },
            },
        },
        config = function()
            local quarto = require 'quarto'
            -- quarto.setup {}
            quarto.setup {
                lspFeatures = {
                    -- NOTE: put whatever languages you want here:
                    languages = { 'r', 'python', 'rust' },
                    chunks = 'all',
                    diagnostics = {
                        enabled = true,
                        triggers = { 'BufWritePost' },
                    },
                    completion = {
                        enabled = true,
                    },
                },
                keymap = {
                    -- NOTE: setup your own keymaps:
                    -- hover = 'K',
                    -- definition = 'gd',
                    -- rename = '<leader>rn',
                    -- references = 'gr',
                    -- format = '<leader>gf',
                },
                codeRunner = {
                    enabled = true,
                    default_method = 'molten',
                },
            }
            vim.keymap.set('n', '<leader>qp', quarto.quartoPreview, { silent = true, noremap = true, desc = '[Q]uarto [p]review' })
        end,
    },
}
