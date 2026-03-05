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
            no_ignore = true,
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
      local builtin = require 'telescope.builtin'
      local themes = require 'telescope.themes'
      local leader = 'si' -- 'si' means 'Search Incremental'

      -- File
      vim.keymap.set('n', leader .. 'f', builtin.find_files, { desc = 'Search [F]iles in cwd' })
      vim.keymap.set('n', leader .. 'F', function()
        builtin.find_files {
          prompt_title = 'Find Files in current buffer',
          cwd = vim.fn.expand '%:p:h',
        }
      end, { desc = 'Search [F]iles in buffer dir' })
      vim.keymap.set('n', leader .. 'n', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Search [n]eovim files' })
      vim.keymap.set('n', leader .. '.', builtin.oldfiles, { desc = 'Search Recent[.] Files' })
      -- Buffer
      vim.keymap.set('n', leader .. 'b', builtin.buffers, { desc = 'Search [B]uffers' })
      -- Search
      vim.keymap.set('n', leader .. 'g', builtin.live_grep, { desc = 'Search by [G]rep' })
      vim.keymap.set('n', leader .. 'w', builtin.grep_string, { desc = 'Search current [W]ord' })
      vim.keymap.set('n', leader .. '/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
          width = 0.8,
        })
      end, { desc = 'Search[/] Fuzzily in current buffer' })
      vim.keymap.set('n', leader .. 'o', function()
        builtin.treesitter {
          show_line = false,
        }
      end, { desc = 'Search TreeSitter [O]utline' })
      -- LSP
      vim.keymap.set('n', leader .. 'd', builtin.diagnostics, { desc = 'Search [D]iagnostics' })
      -- Misc
      -- Telescope
      vim.keymap.set('n', leader .. 'r', builtin.resume, { desc = 'Search [R]esume' })
      vim.keymap.set('n', leader .. 's', builtin.builtin, { desc = 'Search [S]elect telescope' })
      vim.keymap.set('n', leader .. 'h', builtin.help_tags, { desc = 'Search [H]elp' })
      vim.keymap.set('n', leader .. 'k', builtin.keymaps, { desc = 'Search [K]eymaps' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
