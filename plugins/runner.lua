return {
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction ",
      "OverseerClearCache",
    },
    opts = {},
  },
  {
    "Zeioth/compiler.nvim",
    dependencies = {
      {
        "stevearc/overseer.nvim",
        opts = {
          task_list = {
            -- this refers to the window that shows the result
            direction = "bottom",
            min_height = 25,
            max_height = 25,
            default_detail = 1,
            bindings = {
              ["q"] = function() vim.cmd "OverseerClose" end,
            },
          },
        },
        config = function(_, opts) require("overseer").setup(opts) end,
      },
    },
    cmd = { "CompilerOpen", "CompilerToggleResults" },
    opts = {},
  },
  {
    "michaelb/sniprun",
    keys = {},
    opts = {},
    build = "bash ./install.sh 1",
    cmd = "SnipRun",
  },
}
