return {
  {

    "simrat39/rust-tools.nvim",
    keys = {
      { "<leader>Br", name = "Rust commands" },
      { "<leader>Brr", "<cmd>RustRunnables<cr>", desc = "Rust Runnables" },
      { "<leader>BrR", "<cmd>RustLastRun<cr>", desc = "Rust last Run" },
      { "<leader>Brd", "<cmd>RustDebuggables<cr>", desc = "Rust Debuggables" },
      { "<leader>BrD", "<cmd>RustLastDebug<cr>", desc = "Rust last Debug" },
      { "<leader>BrC", "<cmd>RustViewCrateGraph<cr>", desc = "Rust Crate Graph" },
    },
  },
}
