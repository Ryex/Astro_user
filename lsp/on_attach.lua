return function(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    local inlayhints_avail, inlayhints = pcall(require, "lsp-inlayhints")
    if vim.g.inlayhints_enabled == nil then vim.g.inlayhints_enabled = true end
    if inlayhints_avail then
      inlayhints.on_attach(client, bufnr)
      vim.keymap.set(
        "n", "<leader>uH",
        function()
          if vim.g.inlayhints_enabled then
            vim.g.inlayhints_enabled = false
            inlayhints.reset()
          else
            vim.g.inlayhints_enabled = true
            inlayhints.show()
          end
          if vim.g.ui_notifications_enabled then
            require("astronvim.utils").notify(
              string.format("inlayhints %s", vim.g.inlayhints_enabled and "on" or "off")
            )
          end
        end,
        { desc = "Toggle inlay hints" }
      )
    end
  end
end
