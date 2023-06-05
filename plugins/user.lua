return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "Djancyp/custom-theme.nvim",
    config = function() require("custom-theme").setup() end,
  },
  {
    "s1n7ax/nvim-search-and-replace",
    config = function()
      require("nvim-search-and-replace").setup {
        -- file patters to ignore
        ignore = {'**/node_modules/**', '**/.git/**',  '**/.gitignore', '**/.gitmodules','build/**'},
        -- save the changes after replace
        update_changes = false,
        -- keymap for search and replace
        replace_keymap = "<leader>gr",
        -- keymap for search and replace ( this does not care about ignored files )
        replace_all_keymap = "<leader>gR",
        -- keymap for search and replace
        replace_and_save_keymap = "<leader>gu",
        -- keymap for search and replace ( this does not care about ignored files )
        replace_all_and_save_keymap = "<leader>gU",
      }
    end,
  },
}
