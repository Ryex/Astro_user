local wdenv = {}
function wdenv.loadVsDevEnv()
  local powershell_options = {
    shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }

  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end

  -- run, capture, set env from vsdevcmd
  local res = vim.fn.system { "vswhere", "-latest", "-property", "installationPath" }
  if res ~= "" then
    vim.notify "Setting Dev env vars from vsdevcmd.bat"
    local vsdevcmd_path = res:gsub("^%s*(.-)%s*$", "%1") .. "\\Common7\\Tools\\vsdevcmd.bat"
    local vsdev_res = vim.fn.system {
      vim.env.comspec,
      "/C",
      '"' .. vsdevcmd_path .. '"' .. " -no_logo -arch=x64 -host_arch=x64 && set",
    }
    local dev_env = {}
    for line in vsdev_res:gmatch "[^\n\r]+" do
      local s, e = string.find(line, "=", 0, true)
      if s ~= nil then
        local name = line:sub(0, s - 1)
        local value = line:sub(e + 1, #line)
        if name == "Path" then name = "PATH" end
        if
          name ~= "PROMPT"
          and name ~= "PROMPT_INDICATOR"
          and name ~= "PROMPT_MULTILINE_INDICATOR"
          and name ~= "CommandPromptType"
        then
          local old_env = vim.fn.getenv(name)
          if old_env ~= value then dev_env[name] = value end
        end
      end
    end

    local old_path = vim.env.path
    if dev_env.__VSCMD_PREINIT_PATH ~= nil then
      dev_env.PATH = dev_env.PATH:gsub(dev_env.__VSCMD_PREINIT_PATH, old_path)
      dev_env.__VSCMD_PREINIT_PATH = old_path
    end

    for key, value in pairs(dev_env) do
      vim.env[key] = value
      -- vim.notify("Set ENV: " .. key .. " = " .. vim.env[key])
    end
  end
end

return wdenv
