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
      local args, err = _G.splitLaunchArgs(input)
      if err ~= nil then
        vim.notify(err, vim.log.levels.ERROR, {
          title = "Arguments Error",
        })
      else
        mConfig.args = args
        dap.run(mConfig)
      end
    end)
  end)
end

function _G.splitLaunchArgs(input)
  local args = {}
  local start_pat, end_pat, buf, quoted = [=[^(['"])]=], [=[(['"])$]=], nil, nil
  for str in input:gmatch "%S+" do
    local start_quoted = str:match(start_pat)
    local end_quoted = str:match(end_pat)
    local escaped = str:match [=[(\*)['"]$]=]
    if start_quoted and not quoted and not end_quoted then
      buf, quoted = str, start_quoted
    elseif buf and end_quoted == quoted and #escaped % 2 == 0 then
      str, buf, quoted = buf .. " " .. str, nil, nil
    elseif buf then
      buf = buf .. " " .. str
    end
    if not buf then args[#args + 1] = str:gsub(start_pat, ""):gsub(end_pat, "") end
  end
  if buf then return args, "Mismatched quote for " .. buf end
  return args, nil
end

-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  [""] = { -- normal and visual mode
    ["?"] = {
      function() require("hop").hint_patterns() end,
      desc = "Hop patterns",
    },
  },
  n = {
    ["<leader>B"] = { name = "Build commands" },
    ["<leader>c"] = {
      function()
        local bufs = vim.fn.getbufinfo { buflisted = true }
        require("astronvim.utils.buffer").close(0)
        if require("astronvim.utils").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
      end,
      desc = "Close buffer",
    },
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
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
