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

        ---- LEETCODE ----
        {"<C-s>s", ":Leet submit<CR>", description = "[LC] [S]ubmit"},
        {"<C-s>r", ":Leet run<CR>", description = "[LC] [R]un"},
        {"<C-s>c", ":Leet console<CR>", description = "[LC] [C]onsole"},

        ---- VIMWIKI ----
        {"<leader>ww", vim.cmd.VimwikiIndex, description = "Load Vimwiki"},
        {
          "<leader>sc", function()
            if vim.g.created_notepad then
              vim.g.scratch_return_window = vim.fn.tabpagenr()
              vim.cmd("tabfirst")
            else
              vim.g.scratch_return_window = vim.fn.tabpagenr() + 1
              vim.cmd("0tabnew")
              vim.cmd("VimwikiMakeDiaryNote")
              vim.g.created_notepad = true
            end
          end,
          description = "[Vimwiki] Open today's [sc]ratch buffer"
        },
        {
          "<leader>bb", function()
            local return_window = vim.g.scratch_return_window
            if return_window then
              vim.cmd(return_window .. "tabn")
              vim.g.scratch_return_window = nil
            else
              vim.cmd("echo 'No return window set.'")
            end
          end,
          description = "[Vimwiki] Switch [b]ack to [b]uffer after using scratch"
        },
        {
          "<leader>ui", function()
            vim.cmd("VimwikiRebuildTags")
            vim.cmd("VimwikiGenerateTagLinks")
            vim.cmd("w")
          end,
          description = "[Vimwiki] [U]pdate [I]ndex"
        },
        {
          "<leader>cn", function()
            local filename = os.date("%Y-%m-%dT%H%M%S") .. ".md"
            vim.cmd("tabnew ~/notes/" .. filename)
          end,
          description = "[Vimwiki] [C]reate [N]ote"
        },
        {
          "<leader>pn", function()
            local filename = os.date("%Y-%m-%dT%H%M%S") .. ".md"
            vim.cmd("tabnew ~/private_notes/" .. filename)
          end,
          description = "[Vimwiki] [P]rivate [N]ote"
        },
        {"<leader>gd", vim.cmd.VimwikiTabnewLink, description = "[Vimwiki] [G]o to [D]efintion of file in new tab"},
        {"<leader>=", "<Plug>VimwikiAddHeaderLevel", description = "[Vimwiki] Add header level" },

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
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        -- Other
        { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>gl", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
        { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        {
          "<leader>ft", function()
            require("plugins.snacks.custom_pickers").vimwiki_tags()
          end,
          description = "[F]ind [T]ags"
        },

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
          "<leader>t", function()
            vim.cmd.NvimTreeToggle()
          end,
          description = "Toggle Nvim Tree"
        },
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
        {
          "]d", function()
            vim.diagnostic.goto_next()
          end,
          description = "[LSP] Next Diagnostic"
        },
        {
          "[d", function()
            vim.diagnostic.goto_prev()
          end,
          description = "[LSP] Previous Diagnostic"
        },
        {
          "<leader>fd", function()
            vim.lsp.buf.definition()
            vim.cmd("norm zz")
          end,
          description = "[LSP] [F]ind [D]efinition"
        },
        {
          "<leader>fr", function()
            vim.lsp.buf.references()
          end,
          description = "[LSP] [F]ind [R]eferences"
        },
        {
          "<leader>vd", function()
            vim.diagnostic.open_float()
          end,
          description = "[LSP] [V]iew [D]iagnostic"
        },
        {
          "<leader>rs", function()
            vim.lsp.buf.rename()
          end,
          description = "[LSP] [R]ename [S]ymbol"
        },
        {
          "<leader>hi", function()
            vim.lsp.buf.hover()
          end,
          description = "[LSP] [H]over [I]nformation"
        },
        {
          "<F4>", description = "[LSP] Select Code Action"
        },
        {
          "gd", function()
            vim.lsp.buf.definition()
            vim.cmd("norm zz")
          end,
          description = "[LSP] [g]o to [d]efinition"
        },
        {
          "gD", function()
            vim.lsp.buf.declaration()
            vim.cmd("norm zz")
          end,
          description = "[LSP] [g]o to [d]efinition"
        },
        {
          "gi", function()
            vim.lsp.buf.implementation()
            vim.cmd("norm zz")
          end,
          description = "[LSP] [g]o to [i]mplementation"
        },
        {
          "go", function()
            vim.lsp.buf.type_definition()
            vim.cmd("norm zz")
          end,
          description = "[LSP] [g]o to ... type definition"
        },
        {
          "gr", function()
            vim.lsp.buf.references()
          end,
          description = "[LSP] [g]o to [r]eferences"
        },

        ---- GIT SIGNS -----
        {
          "<leader>ga", function()
            vim.cmd.Gitsigns("stage_hunk")
          end,
          mode = { "n", "v" },
          description = "[Git signs] [G]it [A]dd"
        },
        {
          "<leader>gp", function()
            vim.cmd.Gitsigns("preview_hunk")
          end,
          description = "[Git signs] [G]it [P]review"
        },
        {"]c", description = "Next hunk"},
        {"[c", description = "Previous hunk"},
      }
    })
  end,
}
