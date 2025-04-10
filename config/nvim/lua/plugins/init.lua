return {
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    config = function()
      require("fidget").setup({})
    end,
  },

  --{"dstein64/vim-startuptime"},

  -- better status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "catppuccin-macchiato",
          components_separators = '',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {"mode"},
          lualine_b = {"branch", "diff"},
          lualine_c = { { "filename", path = 1 } },
          lualine_x = {
            { "diagnostics", sources = { "nvim_lsp" } },
            "encoding",
            "fileformat",
            "filetype"
          },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        }
      })
      vim.opt.showmode = false -- hide status bar so there aren't two
    end,
  },

  ---- Run pytest in tmux pane
  {
    "vim-test/vim-test",
    event = "VeryLazy",
    config = function()
      vim.g["test#strategy"] = "vimux"
      vim.g["test#python#pytest#executable"] = "pytest"
    end,
  },

  ---- Allow vim to send commands to tmux
  {"preservim/vimux", event = "VeryLazy"},

  -- window zoom
  {
    "anuvyklack/windows.nvim",
    cmd = "WindowsMaximize",
    dependencies = "anuvyklack/middleclass",
  },

  -- easily add/delete/change "surroundings"
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- multiple cursors
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },

  -- git integration
  {"tpope/vim-fugitive"},

  -- repeat motions
  {"tpope/vim-repeat"},

  -- grep
  {
    "dyng/ctrlsf.vim",
    event = "VeryLazy",
    config = function()
      vim.g.ctrlsf_position = "bottom"
      vim.g.ctrlsf_winsize = "25%"
      vim.g.ctrlsf_case_sensitive = "smart"
      vim.g.ctrlsf_default_root = "project"
      vim.g.ctrlsf_ackprg = "/opt/homebrew/bin/rg"
      vim.g.ctrlsf_search_mode = "async"
    end,
  },

  -- better quickfix?
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    event = "VeryLazy"
  },

  -- UML diagrams
  {"scrooloose/vim-slumlord", ft = "plantuml", event = "VeryLazy"},
  {"aklt/plantuml-syntax", ft = "plantuml", event = "VeryLazy"},

  -- smarter indent settings
  { 'tpope/vim-sleuth' },

  -- leetcode
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      lang = "python3",
    },
  },

  -- {
  --   'wassimk/gh-navigator.nvim',
  --   version = "v0.1.3",
  --   event = "VeryLazy",
  --   config = true,
  --   keys = {
  --     { "<leader>or", ":GH pr<CR>", desc = "[O]pen P[R]" },
  --   }
  -- },
}
