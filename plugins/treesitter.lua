return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "lua", "cpp", "python", "rust", "comment", "toml", "json", "cmake" },
    },
  },
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  },
}

