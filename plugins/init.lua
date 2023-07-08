return {
  { "max397574/better-escape.nvim", enabled = true },
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    event = "BufRead",
    config = function() require("hop").setup() end,
  },
  {
    "andymass/vim-matchup",
    event = "BufRead",
    config = function() vim.g.matchup_matchparen_offscreen = {} end,
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
}
