return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          winblend = 10,
          --   mappings = {
          --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          --   },
          -- See `telescope.defaults.vimgrep_arguments`
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            -- Following options are not default.
            '--hidden',
            -- '--no-ignore',
            '--glob',
            '!.git/*',
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            -- no_ignore = true,
            follow = true,
            file_ignore_patterns = { '%.git/' },
          },
          colorscheme = {
            enable_preview = true,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local leader = 'si' -- 'si' means 'Search Incremental'
      local builtin = require 'telescope.builtin'
      local vertical_opts = {
        layout_strategy = 'vertical',
        layout_config = {
          preview_height = 9,
          preview_cutoff = 0,
        },
      }

      -- File
      vim.keymap.set('n', leader .. 's', function()
        builtin.find_files { previewer = false }
      end, { desc = 'Find files in cwd' })
      -- vim.keymap.set('n', leader .. 's', function()
      --   builtin.find_files(require('telescope.themes').get_ivy {
      --     previewer = false,
      --   })
      -- end, { desc = 'Find files in cwd' })

      vim.keymap.set('n', leader .. 'f', function()
        builtin.find_files {
          prompt_title = 'Find Files in current buffer dir',
          cwd = vim.fn.expand '%:p:h',
          previewer = false,
        }
      end, { desc = 'Find [F]iles in buffer dir' })

      vim.keymap.set('n', leader .. 'n', function()
        builtin.find_files {
          cwd = vim.fn.stdpath 'config',
        }
      end, { desc = 'Find [N]eovim files' })

      vim.keymap.set('n', leader .. 'm', function()
        builtin.oldfiles {
          prompt_title = 'Find MRU (Most Recently Used) Files',
          previewer = false,
        }
      end, { desc = 'Find [M]RU Files' })

      -- Buffer
      vim.keymap.set('n', leader .. 'b', function()
        builtin.buffers(vertical_opts)
      end, { desc = 'Find [B]uffers' })

      -- Grep
      vim.keymap.set('n', leader .. 'g', function()
        builtin.live_grep(vertical_opts)
      end, { desc = 'Find by [G]rep' })

      vim.keymap.set('n', leader .. 'w', function()
        builtin.grep_string(vertical_opts)
      end, { desc = 'Find [W]ord in cursor' })

      vim.keymap.set('n', leader .. '/', function()
        local opts = vim.tbl_extend('force', vertical_opts, { sorting_strategy = 'ascending' })
        builtin.current_buffer_fuzzy_find(opts)
      end, { desc = 'Find [/]Fuzzily in current buffer' })

      vim.keymap.set('n', leader .. 'o', function()
        builtin.treesitter {
          symbol_width = 45,
          ignore_symbols = { 'parameter', 'var', 'field' },
        }
      end, { desc = 'Find [O]utline' })

      -- LSP
      vim.keymap.set('n', leader .. 'd', builtin.diagnostics, { desc = 'Find [D]iagnostics' })

      -- Misc
      vim.keymap.set('n', leader .. 'r', builtin.registers, { desc = 'Find [R]egister' })
      vim.keymap.set('n', leader .. '.', builtin.resume, { desc = 'Find Repeat[.] Telescope' })
      vim.keymap.set('n', leader .. 'p', builtin.builtin, { desc = 'Find Telescope [P]icker' })
      vim.keymap.set('n', leader .. 'h', builtin.help_tags, { desc = 'Find [H]elp' })
      vim.keymap.set('n', leader .. 'k', builtin.keymaps, { desc = 'Find [K]eymaps' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
