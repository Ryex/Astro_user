function _G.dapRunConfigWithArgs()
  local dap = require "dap"
  local ft = vim.bo.filetype
  if ft == "" then
    print "Filetype option is required to determine which dap configs are available"
    return
  end
  local configs = dap.configurations[ft]
  if configs == nil then
    print('Filetype "' .. ft .. '" has no dap configs')
    return
  end
  local mConfig = nil

  vim.ui.select(configs, {
    prompt = "Select config to run: ",
    format_item = function(config) return config.name end,
  }, function(config)
    mConfig = config
    -- redraw to make ui selector disappear
    vim.api.nvim_command "redraw"

    if mConfig == nil then
      print "No config selected"
      return
    end
    vim.ui.input({
      prompt = mConfig.name .. " - with args: ",
    }, function(input)
      if input == nil then return end
      local args = vim.split(input, " ", { trimempty = true })
      mConfig.args = args
      dap.run(mConfig)
    end)
  end)
end

-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  [""] = { -- normal and visual mode
    ["f"] = {
      function() require('hop').hint_words({ current_line_only = true }) end,
      desc = "Hop words on current line",
    },
    ["F"] = {
      function() require('hop').hint_words({ current_line_only = false }) end,
      desc = "Hop words",
    },
    ["t"] = {
      function() require('hop').hint_char2({ current_line_only = true }) end,
      desc = "Hop characters on current line",
    },
    ["T"] = {
      function() require('hop').hint_char2({ current_line_only = false }) end,
      desc = "Hop characters",
    },
    [";"] = {
      function() require('hop').hint_lines_skip_whitespace() end,
      desc = "Hop lines start",
    },
    ["?"] = {
      function() require('hop').hint_patterns() end,
      desc = "Hop patterns",
    },
  },
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<leader>lF"] = { "<cmd>FormatModification<cr>", desc = " Format file modifications (via VCS diff) " },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["<leader>dA"] = {
      function() _G.dapRunConfigWithArgs() end,
      desc = "Start a dap config with argument",
    },
    ["<leader>fS"] = { '<cmd>lua require("spectre").open()<CR>', desc = "Open Spectre" },
    ["<leader>sw"] = {
      '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
      desc = "Search current word",
    },
    ["<leader>sp"] = {
      '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      desc = "Search on current file",
    },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  v = {
    ["<leader>sw"] = { '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = "Search current word" },
  },
}
