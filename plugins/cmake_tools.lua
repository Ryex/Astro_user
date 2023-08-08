local utils = require "astronvim.utils"

return {
  {
    "Civitasv/cmake-tools.nvim",
    keys = {
      { "<leader>Bcg", "<cmd>CMakeGenerate<cr>", desc = "Generate CMake config" },
      { "<leader>BcG", "<cmd>CMakeGenerate!<cr>", desc = "Generate clean CMake config" },
      { "<leader>Bcb", "<cmd>CMakeBuild<cr>", desc = "CMake Build" },
      { "<leader>BcB", "<cmd>CMakeBuild!<cr>", desc = "CMake Clean Build" },
      { "<leader>Bci", "<cmd>CMakeInstall<cr>", desc = "CMake install" },
      { "<leader>Bcr", "<cmd>CMakeRun<cr>", desc = "CMake Run" },
      { "<leader>Bcd", "<cmd>CMakeDebug<cr>", desc = "CMake Debug" },
      { "<leader>Bca", "<cmd>CMakeLaunchArgs<cr>", desc = "Set CMake launch args" },
      { "<leader>Bcs", "<cmd>CMakeStop<cr>", desc = "Stop CMake" },
      { "<leader>Bct", "<cmd>CMakeSelectBuildTarget<cr>", desc = "Select CMake build target" },
      { "<leader>BcT", "<cmd>CMakeSelectLaunchTarget<cr>", desc = "Select Cmake launch target" },
      { "<leader>Bcp", "<cmd>CMakeSelectConfigurePreset<cr>", desc = "Select CMake configure preset" },
      { "<leader>BcP", "<cmd>CMakeSelectBuildBPreset<cr>", desc = "Select Cmake build preset" },
      { "<leader>BcC", "<cmd>CMakeClean<cr>", desc = "CMake Clean" },
      { "<leader>Bco", "<cme>CMakeOpen<cr>", desc = "Open CMake window" },
      { "<leader>Bcq", "<cmd>CMakeClose<cr>", desc = "Close CMake window" },
    },
  },
}
