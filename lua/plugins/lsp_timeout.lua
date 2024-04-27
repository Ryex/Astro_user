---@type LazySpec
return {
  {
    "hinell/lsp-timeout.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    init = function()
      vim.g.lspTimeoutConfig = {
        stopTimeout = 1000 * 60 * 10,
        startTimeout = 1000 * 5,
        silent = false,
        filetypes = {
          ignore = {
            "rust"
          },
        },
      }
    end
  },
}
