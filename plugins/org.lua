return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
                work = "E:\\GDProjects\\notes",
              },
            },
          },
        },
      }
    end,
  },
  -- {
  --   "edluffy/hologram.nvim",
  --   config = function() require("hologram").setup() end,
  --   lazy = false,
  --
  --   rocks = { "magick" },
  -- },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "markdown", "norg", "org", "rmd" },
    opts = {},
  },
}
