require "user.reload"

if vim.fn.has "win32" == 1 then
  -- run, capture, setenv from vsdevcmd
  local res = vim.fn.system { "vswhere", "-latest", "-property", "installationPath" }
  if res ~= "" then
    print "Setting Dev env vars from vsdevcmd.bat"
    local vsdevcmd_path = res:gsub("^%s*(.-)%s*$", "%1") .. "\\Common7\\Tools\\vsdevcmd.bat"
    local vsdev_res = vim.fn.system {
      vim.env.comspec,
      "/C",
      '"' .. vsdevcmd_path .. '"' .. " -no_logo -arch=x64 -host_arch=x64 && set",
    }
    for line in vsdev_res:gmatch "[^\n\r]+" do
      local s, e = string.find(line, "=", 0, true)
      if s ~= nil then
        local name = line:sub(0, s - 1)
        local value = line:sub(e + 1, #line)
        vim.fn.setenv(name, value)
      end
    end
  end

  local powershell_options = {
    shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
    shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }

  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end
end

if vim.g.neovide then
  -- Neovide GUI settings
  -- vim.o.guifont = "Fira Code:h8"
  vim.o.guifont = "FiraCode Nerd Font:h8"

  vim.opt.linespace = 0
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  -- Helper function for transparency formatting
  local alpha = function() return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8))) end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 9.0
  vim.g.transparency = 0.8
  -- vim.g.neovide_background_color = "#0f1117" .. alpha()

  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_hide_mouse_when_typing = true

  vim.g.neovide_underline_automatic_scaling = false

  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_no_idle = false

  vim.g.neovide_underline_automatic_scaling = false

  vim.g.neovide_cursor_animation_length = 0.13
  -- vim.g.neovide_cursor_animation_length = 0 -- disable

  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_unfocused_outline_width = 0.125

  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_no_idle = false

  vim.g.neovide_confirm_quit = true

  vim.g.neovide_cursor_animation_length = 0.13
  -- vim.g.neovide_cursor_animation_length = 0 -- disable
  --
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_in_normal_mode = true
  vim.g.neovide_cursor_animate_in_visual_mode = true
  vim.g.neovide_cursor_animate_command_line = true

  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_unfocused_outline_width = 0.125

  -- vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_density = 7.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_speed = 10.0
  vim.g.neovide_cursor_vfx_particle_phase = 1.5
  vim.g.neovide_cursor_vfx_particle_curl = 1.0
  -- END Neovide GUI settings
end

return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "astrodark",
  mappings = {
  },
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
    vim.lsp.set_log_level("off")

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
