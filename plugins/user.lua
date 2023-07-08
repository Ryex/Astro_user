return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "Djancyp/custom-theme.nvim",
    config = function() require("custom-theme").setup() end,
  },
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<Leader>m",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for word under the cursor",
      },
    },
  },
  {
    "chentoast/marks.nvim",
    lazy = false,
    config = function()
      require("marks").setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "",
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = true,
        },
        mappings = {},
      }
    end,
  },
  {
    "monaqa/dial.nvim",
    keys = {
      {
        "<C-a>",
        mode = { "v" },
        function() return require("dial.map").inc_visual() end,
        expr = true,
        desc = "Increment",
      },
      {
        "<C-x>",
        mode = { "v" },
        function() return require("dial.map").dec_visual() end,
        expr = true,
        desc = "Decrement",
      },
      {
        "g<C-a>",
        mode = { "v" },
        function() return require("dial.map").inc_gvisual() end,
        expr = true,
        desc = "Increment",
      },
      {
        "g<C-x>",
        mode = { "v" },
        function() return require("dial.map").dec_gvisual() end,
        expr = true,
        desc = "Decrement",
      },
      {
        "<C-a>",
        function() return require("dial.map").inc_normal() end,
        expr = true,
        desc = "Increment",
      },
      {
        "<C-x>",
        function() return require("dial.map").dec_normal() end,
        expr = true,
        desc = "Decrement",
      },
    },
    config = function()
      local augend = require "dial.augend"
      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.case.new {
            types = { "camelCase", "PascalCase", "snake_case", "SCREAMING_SNAKE_CASE" },
          },
        },
      }
    end,
  },
  {
    "Pocco81/auto-save.nvim",
    event = { "User AstroFile", "InsertEnter" },
    opts = {},
  },
  {
    "lambdalisue/suda.vim",
    keys = {
      {
        "<leader>W",
        ":SudaWrite<CR>",
        desc = "Suda Write",
      },
    },
    cmd = {
      "SudaRead",
      "SudaWrite",
    },
  },
  {
    "f-person/git-blame.nvim",
    event = "User AstroGitFile",
  },
  { "kevinhwang91/nvim-bqf", ft = "qf", opts = {} },
  {
    "m4xshen/smartcolumn.nvim",
    event = { "InsertEnter", "User AstroFile" },
    opts = {},
  },
}
