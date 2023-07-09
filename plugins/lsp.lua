return {
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function() require("lsp_signature").setup {} end,
  },
  {
    "joechrisellis/lsp-format-modifications.nvim",
  },
}
