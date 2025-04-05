return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    dependencies = {
      {"folke/lazydev.nvim", ft = "lua"},
      {"williamboman/mason.nvim", event = "VeryLazy"},
      {"williamboman/mason-lspconfig.nvim", event = "VeryLazy"},
      {"WhoIsSethDaniel/mason-tool-installer.nvim"},
      -- completion
      {"hrsh7th/cmp-nvim-lsp", event = "VeryLazy"},
      {"hrsh7th/nvim-cmp", event = "VeryLazy"},
      "hrsh7th/cmp-nvim-lsp-signature-help",
      -- snippets
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      -- pretty things
      "onsails/lspkind.nvim",
      "brenoprata10/nvim-highlight-colors",
      {"j-hui/fidget.nvim", opts = {}},
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require('lspconfig')

      -- Set border for LSPInfo window
      require('lspconfig.ui.windows').default_options = { border = "rounded" }

      local servers = {
        biome = {
          filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
          root_dir = lspconfig.util.root_pattern('.git', 'tsconfig.json')
        },
        graphql = {
          filetypes = { 'graphql' },
          root_dir = lspconfig.util.root_pattern('.git', '.graphqlrc*', '.graphql.config.*', 'graphql.config.*')
        },
        lua_ls = true,
        marksman = true,
        rubocop = {
          manual_install = true,
          cmd = { "bundle", "exec", "rubocop", "--lsp", "--no-server" },
          filetypes = { "ruby" },
          root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
        },
        -- ruby_lsp = {
        --   init_options = {
        --     addonSettings = {
        --       ["Ruby LSP Rails"] = {
        --         enablePendingMigrationsPrompt = false,
        --       },
        --     }
        --   },
        --   filetypes = { "ruby" },
        --   root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
        -- },
        sorbet = {
          manual_install = true,
          cmd = { "bundle", "exec", "srb", "tc", "--lsp" },
          filetypes = { "ruby" },
          root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
        },
      }

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      require("mason").setup()
      local ensure_installed = {
        "lua_ls",
        "marksman",
      }

      vim.list_extend(ensure_installed, servers_to_install)
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      -- Executes the callback function every time a
      -- language server is attached to a buffer.
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = {buffer = event.buf}

          vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
          vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
          vim.keymap.set('n', '<leader>vd', '<cmd>lua vim.diagnostic.open_float({border = "rounded"})<cr>', opts)
          vim.keymap.set('n', '<leader>rs', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover({border = "rounded"})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>tab split | lua vim.lsp.buf.definition()<cr><cmd>norm zz<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr><cmd>norm zz<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr><cmd>norm zz<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr><cmd>norm zz<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set({'n', 'x'}, 'gf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        end,
      })

      local cmp = require('cmp')
      local format_item_with_lspkind = require("lspkind").cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "...",
        menu = {
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          path = "[Path]",
          luasnip = "[Snippet]",
          nvim_lsp_signature_help = "[Signature]",
        },
      })

      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- lsp
          { name = "buffer", max_item_count = 5 }, -- text within current buffer
          { name = "path", max_item_count = 3 }, -- file system paths
          { name = "luasnip", max_item_count = 3 }, -- snippets
          -- { name = "nvim-lsp-signature-help" },
        }),
        -- Enable pictogram icons for lsp/autocompletion
        formatting = {
          expandable_indicator = true,
          format = function(entry, item)
            local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
            item = format_item_with_lspkind(entry, item)

            if color_item.abbr_hl_group then
              item.kind_hl_group = color_item.abbr_hl_group
              item.kind = color_item.abbr
            end

            return item
          end,
        },
        experimental = {
          ghost_text = true,
        },
      })
    end
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig"
    },
    opts = {
      settings = {
        tsserver_max_memory = 8192
      }
    },
  }
}
