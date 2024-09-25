return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        custom_highlights = function(colors)
          return {
            DiagnosticVirtualTextError = { bg = colors.none },
            DiagnosticVirtualTextWarn = { bg = colors.none },
            DiagnosticVirtualTextInfo = { bg = colors.none },
            DiagnosticVirtualTextHint = { bg = colors.none },
          }
        end,
        integrations = {
          cmp = true,
          fidget = true,
          gitsigns = true,
          headlines = true,
          mason = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          notify = false,
          nvimtree = true,
          telescope = {
            enabled = true,
            style = "nvchad"
          },
          treesitter = true,
          vimwiki = true,
        }
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },
}
