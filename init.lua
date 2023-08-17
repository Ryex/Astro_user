
if vim.fn.has "win32" == 1 then
  local wdenv = require("user.windows_dev_env")
  wdenv.loadVsDevEnv()
end

if vim.g.neovide then
  local neovide_user = require("user.neovide_settings")
  neovide_user.setNeovideSettings()
end

return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  -- colorscheme = "astrodark",
  colorscheme = "astrotheme",
  mappings = {},
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = { virtual_text = true, underline = true },
  lsp = {
    -- customize lsp formatting options
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = {
          "tohtml",
          "gzip",
          "matchit",
          "zipPlugin",
          "netrwPlugin",
          "tarPlugin",
        },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    vim.g.editorconfig = true
    vim.g.inlay_hints_enabled = true
    vim.g.diagnostics_mode = 2
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    vim.lsp.set_log_level "off"

    local map = vim.api.nvim_set_keymap
    -- local unmap = vim.api.nvim_del_keymap

    -- Allow gf to work for non-existing files
    map("n", "gf", ":edit <cfile><cr>", { desc = "Edit file" })
    map("v", "gf", ":edit <cfile><cr>", { desc = "Edit file" })
    map("o", "gf", ":edit <cfile><cr>", { desc = "Edit file" })

    map("n", "<f8>", ":cprev<cr>", { desc = "Previous item in quickfix list" })
    map("n", "<f9>", ":cnext<cr>", { desc = "Next item in quickfix list" })

    -- system clipboard ctrl+c. ctrl+v
    map("n", "<c-c>", '"+y', { desc = "yank to system clipboard" })
    map("v", "<c-c>", '"+y', { desc = "yank to system clipboard" })
    map("n", "<c-v>", '"+p', { desc = "paste form system clipboard" })

    map("c", "<c-v>", "<c-r>+", { noremap = true, desc = "Paste system clipboard (Command mode)" })
    map("i", "<c-v>", "<c-r>+", { noremap = true, desc = "Paste system clipboard (insert mode)" })

    vim.api.nvim_create_augroup("slint_auto", { clear = true })
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      group = "slint_auto",
      pattern = "*.slint",
      callback = function() vim.bo.filetype = "slint" end,
    })

    -- Prettify LSP logs:
    require("vim.lsp.log").set_format_func(vim.pretty_print)
  end,
}
