local function getHostname()
  if vim.fn.has "win32" == 1 then
    local hostname = vim.fn.system { vim.env.comspec, "/C", "hostname" } or ""
    return hostname:gsub("[\n\r]+$", "")
  else
    local f = io.popen "/bin/hostname"
    local hostname = f:read "*a" or ""
    return hostname:gsub("\n$", "")
  end
end

local function getUsername()
  if vim.fn.has "win32" == 1 then
    return vim.env.USERNAME
  else
    return vim.env.USER
  end
end

local function centerLine(str, width)
  local len = #str
  local out = nil
  if len < width then
    local padding = string.rep(" ", math.floor((width - len) / 2))
    out = padding .. str .. padding
  end
  return out or str
end

local function getWorkingDir()
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
      opts.section.header.val = { -- change the header section value
        "░█████╗░░██████╗████████╗██████╗░░█████╗░",
        "██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██╔══██╗",
        "███████║╚█████╗░░░░██║░░░██████╔╝██║░░██║",
        "██╔══██║░╚═══██╗░░░██║░░░██╔══██╗██║░░██║",
        "██║░░██║██████╔╝░░░██║░░░██║░░██║╚█████╔╝",
        "╚═╝░░╚═╝╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝░╚════╝░",
        " ",
        "    ███╗░░██╗██╗░░░██╗██╗███╗░░░███╗     ",
        "    ████╗░██║██║░░░██║██║████╗░████║",
        "    ██╔██╗██║╚██╗░██╔╝██║██╔████╔██║",
        "    ██║╚████║░╚████╔╝░██║██║╚██╔╝██║",
        "    ██║░╚███║░░╚██╔╝░░██║██║░╚═╝░██║",
        "    ╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝",
        centerLine(getUsername() .. "@" .. getHostname(), 42),
        centerLine(getWorkingDir(), 42),
      }
      local utils = require "astronvim.utils"
      local button = utils.alpha_button
      opts.section.buttons.val = utils.extend_tbl(opts.section.buttons.val, {
        button("LDR S p", "   Projects   "),
      })
      return opts
    end,
  },
}
