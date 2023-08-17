return {
  {
    "joechrisellis/lsp-format-modifications.nvim",
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    init = function()
      if vim.fn.has "nvim-0.10" ~= 1 then
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
          callback = function(args)
            if not (args.data and args.data.client_id) then return end
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client.server_capabilities.inlayHintProvider then
              local inlayhints = require "lsp-inlayhints"
              inlayhints.on_attach(client, args.buf)
              require("astronvim.utils").set_mappings({
                n = {
                  ["<leader>uI"] = { inlayhints.toggle, desc = "Toggle inlay hints" },
                },
              }, { buffer = args.buf })
            end
          end,
        })
      end
    end,
    opts = {},
  },
  {
    "p00f/clangd_extensions.nvim",
    optional = true,
    opts = { extensions = { autoSetHints = false } },
  },
  {
    "simrat39/rust-tools.nvim",
    optional = true,
    opts = { tools = { inlay_hints = { auto = false } } },
  },
}
