return {
  {
    "vimwiki/vimwiki",
    event = "VeryLazy",
    init = function()
      vim.g.vimwiki_folding = ""
      vim.g.vimwiki_list = {
        {
          path = "~/notes",
          syntax = "markdown",
          ext = "md",
        },
        {
          path = "~/private_notes",
          syntax = "markdown",
          ext = "md",
        },
      }
      vim.g.vimwiki_ext2syntax = {
        ['.md'] = 'markdown',
        ['.markdown'] = 'markdown',
        ['.mdown'] = 'markdown'
      }
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_url_maxsave = 0

      vim.keymap.set('n', '<leader>ww', '<cmd>lua vim.cmd.VimwikiIndex()<cr>')
      vim.keymap.set('n', '<leader>sc', function()
        if vim.g.created_notepad then
          vim.g.scratch_return_window = vim.fn.tabpagenr()
          vim.cmd("tabfirst")
        else
          vim.g.scratch_return_window = vim.fn.tabpagenr() + 1
          vim.cmd("0tabnew")
          vim.cmd("VimwikiMakeDiaryNote")
          vim.g.created_notepad = true
        end
      end)
      vim.keymap.set('n', '<leader>bb', function()
        local return_window = vim.g.scratch_return_window
        if return_window then
          vim.cmd(return_window .. "tabn")
          vim.g.scratch_return_window = nil
        else
          vim.cmd("echo 'No return window set.'")
        end
      end)
      vim.keymap.set('n', '<leader>ui', function()
        vim.cmd("VimwikiRebuildTags")
        vim.cmd("VimwikiGenerateTagLinks")
        vim.cmd("w")
      end)
      vim.keymap.set('n', '<leader>gf', '<cmd>lua vim.cmd.VimwikiTabnewLink()<cr>')
      vim.keymap.set('n', '<leader>=', '<Plug>VimwikiAddHeaderLevel<cr>')
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
    config = function ()
      require('render-markdown').setup({
        render_modes = true,
        ft = { "markdown", "vimwiki" },
        heading = {
          sign = false,
          -- icons = { "◉ ", "○ ", "✸ ", "✿ " },
        },
        code = {
          sign = false,
          width = "block",
          right_pad = 1,
        },
      })
      vim.treesitter.language.register('markdown', 'vimwiki')
      -- icons
      vim.api.nvim_set_hl(0, 'RenderMarkdownH6', {fg = '#e28488', bg = '#402626', italic = false})
      vim.api.nvim_set_hl(0, 'RenderMarkdownH5', {fg = '#e3a589', bg = '#66493c', italic = false})
      vim.api.nvim_set_hl(0, 'RenderMarkdownH4', {fg = '#a1d182', bg = '#3d4f2f', italic = false})
      vim.api.nvim_set_hl(0, 'RenderMarkdownH3', {fg = '#62ccc4', bg = '#224541', italic = false})
      vim.api.nvim_set_hl(0, 'RenderMarkdownH2', {fg = '#75a5dc', bg = '#2b3d4f', italic = false})
      vim.api.nvim_set_hl(0, 'RenderMarkdownH1', {fg = '#e695ad', bg = '#6b454f', italic = false})
      -- background line
      vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', {fg = '#e28488', bg = '#402626', italic = false})
      vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', {fg = '#e3a589', bg = '#66493c', italic = false})
      vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', {fg = '#a1d182', bg = '#3d4f2f', italic = false})
      vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', {fg = '#62ccc4', bg = '#224541', italic = false})
      vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', {fg = '#75a5dc', bg = '#2b3d4f', italic = false})
      vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', {fg = '#e695ad', bg = '#6b454f', italic = false})
    end
  },

  -- display images
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    ft = "vimwiki",
    opts = {},
    keys = {
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  }
}
