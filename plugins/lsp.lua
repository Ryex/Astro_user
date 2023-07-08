local utils = require "astronvim.utils"
return {
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    after = { "mason-lspconfig.nvim" },
  },
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    after = { "mason-lspconfig.nvim" },
  },
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = function(_, opts) opts.ensure_instaled = utils.list_insert_unique(opts.ensure_installed, "codelldb") end,
      },
    },
    opts = {},
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
  { "PProvost/vim-ps1", ft = "ps1" },
}
