return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "f3fora/cmp-spell",
      "paopaol/cmp-doxygen",
      "ray-x/cmp-treesitter",
    },
    opts = function(_, opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      local cmp = require "cmp"
      local compare = require "cmp.config.compare"
      local luasnip = require "luasnip"
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      return require("astronvim.utils").extend_tbl(opts, {
        window = {
          completion = {
            border = "rounded",
            col_offset = -1,
            side_padding = 0,
          },
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "doxygen", priority = 700 },
          { name = "calc", priority = 650 },
          { name = "emoji", priority = 700 },
          { name = "path", priority = 500 },
          { name = "treesitter", priority = 400 },
          { name = "buffer", priority = 250 },
          {
            name = "spell",
            priority = 200,
            option = {
              keep_all_entries = false,
              enable_in_context = function() return require("cmp.config.context").in_treesitter_capture "spell" end,
            },
          },
        },
        sorting = {
          comparators = {
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            function(entry1, entry2)
              local _, entry1_under = entry1.completion_item.label:find "^_+"
              local _, entry2_under = entry2.completion_item.label:find "^_+"
              entry1_under = entry1_under or 0
              entry2_under = entry2_under or 0
              if entry1_under > entry2_under then
                return false
              elseif entry1_under < entry2_under then
                return true
              end
            end,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
          },
        },
        -- mapping = {
        --   -- tab complete
        --   ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --       cmp.select_next_item()
        --       -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        --       -- they way you will only jump inside the snippet region
        --     elseif luasnip.expand_or_jumpable() then
        --       luasnip.expand_or_jump()
        --     elseif has_words_before() then
        --       cmp.complete()
        --     else
        --       fallback()
        --     end
        --   end, { "i", "s" }),
        --   -- <C-n> and <C-p> for navigating snippets
        --   ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        --   ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        --   -- <C-j> for starting completion
        --   ["<C-Space>"] = cmp.mapping(function()
        --     if cmp.visible() then
        --       cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
        --     else
        --       cmp.complete()
        --     end
        --   end, { "i", "s" }),
        --   ["<CR>"] = cmp.mapping {
        --     i = function(fallback)
        --       if cmp.visible() and cmp.get_active_entry() then
        --         cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
        --       else
        --         fallback()
        --       end
        --     end,
        --     s = cmp.mapping.confirm { select = true },
        --     c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
        --   },
        -- },
        experimental = {
          ghost_text = true,
        },
        -- performance = {
        --   debounce = 300,
        --   throttle = 120,
        --   fetching_timeout = 100,
        -- },
      })
    end,
  },
  {
    "Saecki/crates.nvim",
    init = function()
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          require("cmp").setup.buffer { sources = { { name = "crates" } } }
          require "crates"
        end,
      })
    end,
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      }

      -- Crates mappings:
      local map = vim.api.nvim_set_keymap
      map("n", "<leader>Ct", ":lua require('crates').toggle()<cr>", { desc = "Toggle extra crates.io information" })
      map("n", "<leader>Cr", ":lua require('crates').reload()<cr>", { desc = "Reload information from crates.io" })
      map("n", "<leader>CU", ":lua require('crates').upgrade_crate()<cr>", { desc = "Upgrade a create" })
      map("v", "<leader>CU", ":lua require('crates').upgrade_crates()<cr>", { desc = "Upgrade selected crates" })
      map("n", "<leader>CA", ":lua require('crates').upgrade_all_crates()<cr>", { desc = "Upgrade all crates" })
    end,
  },
}
