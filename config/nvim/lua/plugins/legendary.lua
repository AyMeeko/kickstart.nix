return {
  "mrjones2014/legendary.nvim",
  version = "v2.1.0",
  -- since legendary.nvim handles all your keymaps/commands,
  -- its recommended to load legendary.nvim before other plugins
  priority = 10000,
  lazy = false,
  -- sqlite is only needed if you want to use frecency sorting
  dependencies = {"kkharji/sqlite.lua"},
  config = function()
    require("legendary").setup({
      keymaps = {
        -- General vim keymaps --
        {"gcc", description = "Toggle comment line"},
        {"<C-l>", vim.cmd.tabn, description = "Tab next"},
        {"<C-h>", vim.cmd.tabp, description = "Tab previous"},
        {"<leader>/", vim.cmd.nohlsearch, description = "Clear last search"},
        {"<leader><tab>", vim.cmd.bprev, description = "Switch to previous buffer"},
        {"<leader>fj", description = "[F]ormat [J]son"},
        {"<space>", description = "Toggle Fold"},
        {"<leader>yp", function()
          vim.cmd("let @+ = expand('%')")
        end, description = "[Y]ank current file [p]ath to system clipboard"},
        {"<leader>sp", function()
          vim.cmd("echo expand('%')")
        end, description = "[S]how current file [p]ath"},

        -- Plugin keymaps --
        {"<leader>fk", ":Legendary<CR>", description = "Open Legendary"},
        {"<C-f>f", ":CtrlSF ", description = "Launch CtrlSF"},
        {"<leader>gs", vim.cmd.Git, description = "[Git] [G]it [S]tatus"},
        {"<leader>gd", vim.cmd.Gvdiffsplit, description = "[Git] [G]it [D]iff"},
        {
          "<leader>gb", function()
            vim.cmd.Git("blame")
          end,
          description = "[Git] [G]it [B]lame"
        },
        {"<leader>ct", ":ColorizerToggle<CR>", description = "[C]olorizer [t]oggle"},
        -- Defined in note_taking.lua
        { "<leader>p", desc = "Paste image from system clipboard" },

        ---- VIMWIKI ----
        -- Defined in note_taking.lua
        {"<leader>ww", description = "Load Vimwiki"},
        {"<leader>sc", description = "[Vimwiki] Open today's [sc]ratch buffer"},
        {"<leader>bb", description = "[Vimwiki] Switch [b]ack to [b]uffer after using scratch"},
        {"<leader>ui", description = "[Vimwiki] [U]pdate [I]ndex"},
        {"<leader>gf", description = "[Vimwiki] [G]o to [F]ile in new tab"},
        {"<leader>=", description = "[Vimwiki] Add header level" },

        ---- SNACKS ----
        -- Top Pickers & Explorer
        { "<C-p>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        { "<leader>bl", function() Snacks.picker.buffers() end, desc = "[B]uffer [l]ist" },
        { "<leader>st", function() Snacks.picker.grep() end, desc = "[S]earch [t]ext" },
        { "<leader>n", function() Snacks.picker.notifications() end, desc = "[N]otification History" },
        -- find
        { "<leader>ff", function() Snacks.picker.files() end, desc = "[F]ind [F]iles" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "[F]ind [G]it Files" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "[F]ind [R]ecent" },
        -- Grep
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[S]earch [W]ord - Visual selection or word", mode = { "n", "x" } },
        -- Other
        { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>gh", function() Snacks.gitbrowse() end, desc = "Browse in [G]it[h]ub", mode = { "n", "v" } },
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
        { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        {"<leader>gl",  function() Snacks.picker.git_log({layout = {preview = true, fullscreen = true}}) end, desc = "[G]it [L]og"},
        {
          "<leader>ft", function()
            require("plugins.snacks.custom_pickers").vimwiki_tags()
          end,
          description = "[F]ind [T]ags"
        },
        -- Defined in snacks.lua
        { "<leader>us", desc = "Toggle Spelling" },
        { "<leader>uw", desc = "Toggle Wrap" },
        { "<leader>uL", desc = "Toggle Relative Number" },
        { "<leader>ul", desc = "Toggle Line Number" },
        { "<leader>ud", desc = "Toggle Diagnostics" },
        { "<leader>uc", desc = "Toggle Conceal Level" },
        { "<leader>uT", desc = "Toggle Treesitter" },
        { "<leader>uh", desc = "Toggle Inlay Hints" },
        { "<leader>ug", desc = "Toggle Indent Lines" },
        { "<leader>uD", desc = "Toggle Dim Lines" },

        ---- VIM-TEST ----
        {
          "<leader>rt", function()
            vim.cmd.TestNearest()
          end,
          description = "[Test] [R]un [T]est"
        },
        {
          "<leader>rf", function()
            vim.cmd.TestFile()
          end,
          description = "[Test] [R]un [F]ile"
        },

        ---- NVIM TREE ----
        {
          "<leader>f<space>", function()
            vim.cmd.NvimTreeFindFile()
          end,
          description = "Find Current File in Nvim Tree"
        },

        ---- ZOOM WINDOW ----
        {
          "<leader>zw", function()
            require('windows').setup()
            vim.cmd.WindowsMaximize()
          end,
          description = "[Z]oom into [W]indow"
        },

        ---- LSP ----
        -- Defined in lsp.lua
        {"]d", description = "[LSP] Next Diagnostic"},
        {"[d", description = "[LSP] Previous Diagnostic"},
        {"<leader>vd", description = "[LSP] [V]iew [D]iagnostic"},
        {"<leader>rs", description = "[LSP] [R]ename [S]ymbol"},
        {"<leader>hi", description = "[LSP] [H]over [I]nformation"},
        {"<F4>", description = "[LSP] Select Code Action"},
        {"gd", description = "[LSP] [g]o to [d]efinition"},
        {"gD", description = "[LSP] [g]o to [d]eclaration"},
        {"gi", description = "[LSP] [g]o to [i]mplementation"},
        {"go", description = "[LSP] [g]o to ... type definition"},
        {"gr", description = "[LSP] [g]o to [r]eferences"},
        {"gf", description = "[LSP] [g]o [f]ormat file"},

        ---- GIT SIGNS ----
        -- Defined in gitsigns.lua
        {"]c", description = "Next hunk"},
        {"[c", description = "Previous hunk"},
        {"<leader>ga", description = "[Git signs] [G]it [A]dd"},
        {"<leader>gp", description = "[Git signs] [G]it [P]review"},
      }
    })
  end,
}
