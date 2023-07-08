local utils = require "astronvim.utils"
return {
  {
    "Weissle/persistent-breakpoints.nvim",
    event = "BufReadPost",
    opts = function(_, opts)
      return require("astronvim.utils").extend_tbl(opts, {
        load_breakpoints_event = { "BufReadPost" },
      })
    end,
    keys = {
      {
        "<leader>db",
        function() require("persistent-breakpoints.api").toggle_breakpoint() end,
        { silent = true },
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dB",
        function() require("persistent-breakpoints.api").clear_all_breakpoints() end,
        { silent = true },
        desc = "Clear Breakpoints",
      },
      {
        "<leader>dC",
        function() require("persistent-breakpoints.api").set_conditional_breakpoint() end,
        { silent = true },
        desc = "Conditional Breakpoint",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "python")
      if not opts.handlers then opts.handlers = {} end
      opts.handlers.python = function() end -- make sure python doesn't get set up by mason-nvim-dap, it's being set up by nvim-dap-python
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    ft = "python", -- NOTE: ft: lazy-load on filetype
    config = function(_, opts)
      local path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"
      require("dap-python").setup(path, opts)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    enabled = true,
    dependencies = {
      "suketa/nvim-dap-ruby",
      name = "dap-ruby",
      opts = {},
    },
  },
}
