return {
  rust_analyzer = function(_, opts)
    require("rust-tools").setup {
      server = opts,
      tools = {
        inlay_hints = {
          auto = false,
        },
      },
    }
  end,
  clangd = function(_, opts)
    require("clangd_extensions").setup {
      server = opts,
      extensions = {
        autoSetHints = false,
      },
    }
  end,
}
