return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    opts = {
      options = {
        highlight_inactive_windows = true,
      },
    },
  },
  {
    "Djancyp/custom-theme.nvim",
    config = function() require("custom-theme").setup() end,
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
  -- {
  --   "Pocco81/auto-save.nvim",
  --   event = { "User AstroFile", "InsertEnter" },
  --   opts = {
  --     enabled = false, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
  --     execution_message = {
  --       message = function() -- message to print on save
  --         return ("AutoSave: saved at " .. vim.fn.strftime "%H:%M:%S")
  --       end,
  --       dim = 0.18, -- dim the color of `message`
  --       cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
  --     },
  --     trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
  --     -- function that determines whether to save the current buffer or not
  --     -- return true: if buffer is ok to be saved
  --     -- return false: if it's not ok to be saved
  --     condition = function(buf)
  --       local fn = vim.fn
  --       local utils = require "auto-save.utils.data"
  --
  --       if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
  --         return true -- met condition(s), can save
  --       end
  --       return false -- can't save
  --     end,
  --     write_all_buffers = false, -- write all buffers when the current one meets `condition`
  --     debounce_delay = 5000, -- saves the file at most every `debounce_delay` milliseconds
  --     callbacks = {
  --       -- functions to be executed at different intervals
  --       enabling = nil, -- ran when enabling auto-save
  --       disabling = nil, -- ran when disabling auto-save
  --       before_asserting_save = nil, -- ran before checking `condition`
  --       before_saving = nil, -- ran before doing the actual save
  --       after_saving = nil, -- ran after doing the actual save
  --     },
  --   },
  -- },
  {
    "m4xshen/smartcolumn.nvim",
    event = { "InsertEnter", "User AstroFile" },
    opts = {
      colorcolumn = "+0",
      scope = "window",
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    ft = { "python" },
    opts = {},
    keys = { { "<leader>lv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
  },
}
