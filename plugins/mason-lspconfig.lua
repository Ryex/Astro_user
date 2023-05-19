-- use mason-lspconfig to configure LSP installations
return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    automatic_installation = true,
    ensure_installed = {
      "clangd",
      "cssls",
      "html",
      "marksman",
      "jsonls",
      "pyright",
      "pylsp",
      "sqlls",
      "lua_ls",
      "tsserver",
      "yamlls",
      "rust_analyzer",
    },
  },
}
