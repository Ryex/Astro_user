return {
  { "max397574/better-escape.nvim", enabled = true },
  {
    "ur4ltz/surround.nvim",
    event = "BufRead",
    config = function()
      require("surround").setup {
        mappings_style = "surround",
        map_insert_mode = false,
      }
    end,
  },
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    event = "BufRead",
    config = function() require("hop").setup() end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function() require("lsp_signature").setup {} end,
  },
  {
    "andymass/vim-matchup",
    event = "BufRead",
    config = function() vim.g.matchup_matchparen_offscreen = {} end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = true
  },
  {
    "joechrisellis/lsp-format-modifications.nvim",
  },
  {
    "simrat39/rust-tools.nvim",
    after = { "mason-lspconfig.nvim" },
    -- Is configured via the server_registration_override installed below!
    config = function()
      require("rust-tools").setup {
        server = require("astronvim.utils.lsp").config "rust_analyzer",
        tools = {
          inlay_hints = {
            auto = false,
            parameter_hints_prefix = "  ",
            other_hints_prefix = "  ",
          },
        },
      }
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
  },
  {
    "Saecki/crates.nvim",
    after = "nvim-cmp",
    config = function()
      require("crates").setup()
      astronvim.add_cmp_source { name = "crates", priority = 1100 }

      -- Crates mappings:
      local map = vim.api.nvim_set_keymap
      map("n", "<leader>Ct", ":lua require('crates').toggle()<cr>", { desc = "Toggle extra crates.io information" })
      map("n", "<leader>Cr", ":lua require('crates').reload()<cr>", { desc = "Reload information from crates.io" })
      map("n", "<leader>CU", ":lua require('crates').upgrade_crate()<cr>", { desc = "Upgrade a create" })
      map("v", "<leader>CU", ":lua require('crates').upgrade_crates()<cr>", { desc = "Upgrade selected crates" })
      map("n", "<leader>CA", ":lua require('crates').upgrade_all_crates()<cr>", { desc = "Upgrade all crates" })
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = function()
      local prefix = "<leader>s"
      return {
        mapping = {
          send_to_qf = { map = prefix .. "q" },
          replace_cmd = { map = prefix .. "c" },
          show_option_menu = { map = prefix .. "o" },
          run_current_replace = { map = prefix .. "C" },
          run_replace = { map = prefix .. "R" },
          change_view_mode = { map = prefix .. "v" },
          resume_last_search = { map = prefix .. "l" },
        },
      }
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
    config = function()
      local actions = require "diffview.actions"
      local utils = require "astronvim.utils" --  astronvim utils

      local prefix = "<leader>D"

      utils.set_mappings {
        n = {
          [prefix] = { name = "Diff View" },
          [prefix .. "<cr>"] = {
            "<cmd>DiffviewOpen<cr>",
            desc = "Open DiffView",
          },
          [prefix .. "h"] = {
            "<cmd>DiffviewFileHistory %<cr>",
            desc = "Open DiffView File History",
          },
          [prefix .. "H"] = {
            "<cmd>DiffviewFileHistory<cr>",
            desc = "Open DiffView Branch History",
          },
        },
      }

      local build_keymaps = function(maps)
        local out = {}
        local i = 1
        for lhs, def in
          pairs(utils.extend_tbl(maps, {
            [prefix .. "q"] = {
              "<cmd>DiffviewClose<cr>",
              desc = "Quit Diffview",
            }, -- Toggle the file panel.
            ["]D"] = {
              actions.select_next_entry,
              desc = "Next Difference",
            }, -- Open the diff for the next file
            ["[D"] = {
              actions.select_prev_entry,
              desc = "Previous Difference",
            }, -- Open the diff for the previous file
            ["[C"] = { actions.prev_conflict, desc = "Next Conflict" }, -- In the merge_tool: jump to the previous conflict
            ["]C"] = { actions.next_conflict, desc = "Previous Conflict" }, -- In the merge_tool: jump to the next conflict
            ["Cl"] = { actions.cycle_layout, desc = "Cycle Diff Layout" }, -- Cycle through available layouts.
            ["Ct"] = { actions.listing_style, desc = "Cycle Tree Style" }, -- Cycle through available layouts.
            ["<leader>e"] = {
              actions.toggle_files,
              desc = "Toggle Explorer",
            }, -- Toggle the file panel.
            ["<leader>o"] = {
              actions.focus_files,
              desc = "Focus Explorer",
            }, -- Bring focus to the file panel
          }))
        do
          local opts
          local rhs = def
          local mode = { "n" }
          if type(def) == "table" then
            if def.mode then mode = def.mode end
            rhs = def[1]
            def[1] = nil
            def.mode = nil
            opts = def
          end
          out[i] = { mode, lhs, rhs, opts }
          i = i + 1
        end
        return out
      end

      require("diffview").setup {
        view = { merge_tool = { layout = "diff4_mixed" } },
        keymaps = {
          disable_defaults = true,
          view = build_keymaps {
            [prefix .. "o"] = {
              actions.conflict_choose "ours",
              desc = "Take Ours",
            }, -- Choose the OURS version of a conflict
            [prefix .. "t"] = {
              actions.conflict_choose "theirs",
              desc = "Take Theirs",
            }, -- Choose the THEIRS version of a conflict
            [prefix .. "b"] = {
              actions.conflict_choose "base",
              desc = "Take Base",
            }, -- Choose the BASE version of a conflict
            [prefix .. "a"] = {
              actions.conflict_choose "all",
              desc = "Take All",
            }, -- Choose all the versions of a conflict
            [prefix .. "0"] = {
              actions.conflict_choose "none",
              desc = "Take None",
            }, -- Delete the conflict region
          },
          diff3 = build_keymaps {
            [prefix .. "O"] = {
              actions.diffget "ours",
              mode = { "n", "x" },
              desc = "Get Our Diff",
            }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "T"] = {
              actions.diffget "theirs",
              mode = { "n", "x" },
              desc = "Get Their Diff",
            }, -- Obtain the diff hunk from the THEIRS version of the file
          },
          diff4 = build_keymaps {
            [prefix .. "B"] = {
              actions.diffget "base",
              mode = { "n", "x" },
              desc = "Get Base Diff",
            }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "O"] = {
              actions.diffget "ours",
              mode = { "n", "x" },
              desc = "Get Our Diff",
            }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "T"] = {
              actions.diffget "theirs",
              mode = { "n", "x" },
              desc = "Get Their Diff",
            }, -- Obtain the diff hunk from the THEIRS version of the file
          },
          file_panel = build_keymaps {
            j = actions.next_entry, -- Bring the cursor to the next file entry
            k = actions.prev_entry, -- Bring the cursor to the previous file entry.
            o = actions.select_entry,
            S = actions.stage_all, -- Stage all entries.
            U = actions.unstage_all, -- Unstage all entries.
            X = actions.restore_entry, -- Restore entry to the state on the left side.
            L = actions.open_commit_log, -- Open the commit log panel.
            Cf = { actions.toggle_flatten_dirs, desc = "Flatten" }, -- Flatten empty subdirectories in tree listing style.
            R = actions.refresh_files, -- Update stats and entries in the file list.
            ["-"] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
            ["<down>"] = actions.next_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry, -- Open the diff for the selected entry.
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<c-b>"] = actions.scroll_view(-0.25), -- Scroll the view up
            ["<c-f>"] = actions.scroll_view(0.25), -- Scroll the view down
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
          },
          file_history_panel = build_keymaps {
            j = actions.next_entry,
            k = actions.prev_entry,
            o = actions.select_entry,
            y = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
            L = actions.open_commit_log,
            zR = { actions.open_all_folds, desc = "Open all folds" },
            zM = { actions.close_all_folds, desc = "Close all folds" },
            ["?"] = { actions.options, desc = "Options" }, -- Open the option panel
            ["<down>"] = actions.next_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<C-A-d>"] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
            ["<c-b>"] = actions.scroll_view(-0.25),
            ["<c-f>"] = actions.scroll_view(0.25),
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
          },
          option_panel = {
            q = actions.close,
            o = actions.select_entry,
            ["<cr>"] = actions.select_entry,
            ["<2-LeftMouse"] = actions.select_entry,
          },
        },
      }
    end,
  },
}
