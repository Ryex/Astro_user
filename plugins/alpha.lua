---get the system hostname
---@return string
local function get_hostname()
  local hostname = ""
  if vim.fn.has "win32" == 1 then
    hostname = vim.fn.system { vim.env.comspec, "/C", "hostname" } or ""
  else
    local f = io.popen "/bin/hostname"
    if f ~= nil then hostname = f:read "*a" or "" end
  end
  hostname = hostname:gsub("[\n\r]+$", "")
  return hostname
end

--- get the current user's username
---@return string
local function get_username()
  if vim.fn.has "win32" == 1 then
    return vim.env.USERNAME
  else
    return vim.env.USER
  end
end

--- center a line of text in width
---@param str string
---@param width integer
---@return string
local function center_line(str, width)
  local len = vim.fn.strdisplaywidth(str)
  local out = nil
  if len < width then
    local padding = string.rep(" ", math.floor((width - len) / 2))
    out = padding .. str .. padding
  end
  return out or str
end

--- center a table of strings by using the longest line and centering on that width
---@param tbl table<integer, string>
---@return table<integer, string>
local function center_lines(tbl)
  local longest_line = 0
  for _, line in ipairs(tbl) do
    if #line > longest_line then longest_line = #line end
  end

  if longest_line % 2 ~= 0 then longest_line = longest_line + 1 end

  local out = {}
  for _, line in ipairs(tbl) do
    table.insert(out, center_line(line, longest_line))
  end
  return out
end

--- get current working directory with HOME path replaced with ~
---@return string
local function get_working_dir()
  local pwd = os.getenv "PWD" or io.popen("cd"):read() or ""
  local home = os.getenv "HOME"
  local workingDir = pwd
  if home ~= nil then workingDir = workingDir:gsub(home, "~") end
  return workingDir .. "/"
end

return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts) -- override the options using lazy.nvim
      opts.section.header.val = center_lines { -- change the header section value
        "░█████╗░░██████╗████████╗██████╗░░█████╗░",
        "██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██╔══██╗",
        "███████║╚█████╗░░░░██║░░░██████╔╝██║░░██║",
        "██╔══██║░╚═══██╗░░░██║░░░██╔══██╗██║░░██║",
        "██║░░██║██████╔╝░░░██║░░░██║░░██║╚█████╔╝",
        "╚═╝░░╚═╝╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝░╚════╝░",
        " ",
        "███╗░░██╗██╗░░░██╗██╗███╗░░░███╗",
        "████╗░██║██║░░░██║██║████╗░████║",
        "██╔██╗██║╚██╗░██╔╝██║██╔████╔██║",
        "██║╚████║░╚████╔╝░██║██║╚██╔╝██║",
        "██║░╚███║░░╚██╔╝░░██║██║░╚═╝░██║",
        "╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝",
        center_line(get_username() .. "@" .. get_hostname(), 42),
        center_line(get_working_dir(), 42),
      }
      local utils = require "astronvim.utils"
      local button = utils.alpha_button
      opts.section.buttons.val = utils.extend_tbl(opts.section.buttons.val, {
        button("LDR P", "   Projects   "),
      })
      return opts
    end,
  },
}
