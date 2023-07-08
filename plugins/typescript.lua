return {
  {
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
    opts = {},
    event = "BufRead package.json",
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
    },
    opts = function() return { server = require("astronvim.utils.lsp").config "tsserver" } end,
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    opts = {},
  },
}
