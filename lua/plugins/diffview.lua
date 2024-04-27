local prefix = "<leader>D"
return {
  "sindrets/diffview.nvim",
  event = "User AstroGitFile",

  opts = {
    mappings = {
      n = {
        -- [prefix] = { name = "Diff View" },
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
    },
  },
}
