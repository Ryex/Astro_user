return {
  {
    "simrat39/rust-tools.nvim",
    after = { "mason-lspconfig.nvim" },
    -- Is configured via the server_registration_override installed below!
  },
  {
    "p00f/clangd_extensions.nvim",
    after = { "mason-lspconfig.nvim" },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function() require("lsp_signature").setup {} end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = true,
  },
  {
    "joechrisellis/lsp-format-modifications.nvim",
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach",
    opts = {},
  },
  {
    "smjonas/inc-rename.nvim",
    opts = {},
    keys = {
      {
        "<leader>lr",
        function()
          require "inc_rename"
          return ":IncRename " .. vim.fn.expand "<cword>"
        end,
        expr = true,
        desc = "IncRename",
      },
    },
  },
}
