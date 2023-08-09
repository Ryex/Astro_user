return function(client, bufnr)
  -- toggle inlay hints
  -- if client.server_capabilities.inlayHintProvider then
  --   local inlayhints_avail, inlayhints = pcall(require, "lsp-inlayhints")
  --   if vim.g.inlayhints_enabled == nil then vim.g.inlayhints_enabled = true end
  --   if inlayhints_avail then
  --     inlayhints.on_attach(client, bufnr)
  --     vim.keymap.set("n", "<leader>uH", function()
  --       if vim.g.inlayhints_enabled then
  --         vim.g.inlayhints_enabled = false
  --         inlayhints.reset()
  --       else
  --         vim.g.inlayhints_enabled = true
  --         inlayhints.show()
  --       end
  --       if vim.g.ui_notifications_enabled then
  --         require("astronvim.utils").notify(string.format("inlayhints %s", vim.g.inlayhints_enabled and "on" or "off"))
  --       end
  --     end, { desc = "Toggle inlay hints" })
  --   end
  -- end

  -- setup clangd source header switch
  if client.name == "clangd" then
    vim.keymap.set("n", "gH", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch between source and header files" })
    if vim.fn.has "nvim-0.10" ~= 1 then
      require("clangd_extensions.inlay_hints").setup_autocmd()
      require("clangd_extensions.inlay_hints").set_inlay_hints()

      require("astronvim.utils").set_mappings({
        n = {
          ["<leader>uH"] = { "<cmd>ClangdToggleInlayHints<cr>", desc = "Toggle inlay hints (clangd)" },
        },
      }, { buffer = args.buf })
    end
  end
end
