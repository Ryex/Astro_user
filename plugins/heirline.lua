---comment
---@param module string
---@return boolean
local function is_loaded(module)
  return package.loaded[module] ~= nil
end

local utils = require "astronvim.utils"

return {
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astronvim.utils.status"
      local heirline_conditions = require "heirline.conditions"
      local function is_cmake()

          local cmake = require "cmake-tools"
          return cmake.is_cmake_project()
      end

      local function is_cmake_and_preset()
          local cmake = require "cmake-tools"
          return cmake.is_cmake_project() and cmake.has_cmake_preset()
      end

      local cmake_status = {
        condition = function() return is_loaded "cmake-tools" end,
        status.component.builder {
          provider = function()
            local cmake = require "cmake-tools"
            local c_preset = cmake.get_configure_preset()
            return utils.get_icon "Search" .. " CMake: [" .. (c_preset and c_preset or "X") .. "]"
          end,

          padding = { right = 1 },
          condition = is_cmake_and_preset,
          on_click = {
            --- _self, _minwid, nclicks, button, _mods
            callback = function(_, _, nclicks, button, _)
              if nclicks == 1 then
                if button == "l" then vim.cmd "CMakeSelectConfigurePreset" end
              end
            end,
            name = "statusline_onclick_cmake_select_config_preset",
          },
          update = "BufEnter",
        },
        status.component.builder {
          provider = function()
            local cmake = require "cmake-tools"
            local type = cmake.get_build_type()
            return utils.get_icon "Search" .. " CMake: [" .. (type and type or "") .. "]"
          end,

          padding = { right = 1 },
          condition = is_cmake_and_preset,
          on_click = {
            --- _self, _minwid, nclicks, button, _mods
            callback = function(_, _, nclicks, button, _)
              if nclicks == 1 then
                if button == "l" then vim.cmd "CMakeSelectBuildType" end
              end
            end,
            name = "statusline_onclick_cmake_select_build_type",
          },
          update = "BufEnter",
        },
        status.component.builder {
          provider = function()
            local cmake = require "cmake-tools"
            local kit = cmake.get_kit()
            return utils.get_icon "Selected" .. " [" .. (kit and kit or "X") .. "]"
          end,

          padding = { right = 1 },
          condition = is_cmake_and_preset,
          on_click = {
            --- _self, _minwid, nclicks, button, _mods
            callback = function(_, _, nclicks, button, _)
              if nclicks == 1 then
                if button == "l" then vim.cmd "CMakeSelectKit" end
              end
            end,
            name = "statusline_onclick_cmake_select_kit",
          },
          update = "BufEnter",
        },
        status.component.builder {
          provider = function() return " Build" end,

          padding = { right = 1 },
          condition = is_cmake,
          on_click = {
            --- _self, _minwid, nclicks, button, _mods
            callback = function(_, _, nclicks, button, _)
              if nclicks == 1 then
                if button == "l" then vim.cmd "CMakeBuild" end
              end
            end,
            name = "statusline_onclick_cmake_build",
          },
          update = "BufEnter",
        },
        status.component.builder {
          provider = function()
            local cmake = require "cmake-tools"
            local b_preset = cmake.get_build_preset()
            return utils.get_icon "Search" .. " [" .. (b_preset and b_preset or "X") .. "]"
          end,

          padding = { right = 1 },
          condition = is_cmake_and_preset,
          on_click = {
            --- _self, _minwid, nclicks, button, _mods
            callback = function(_, _, nclicks, button, _)
              if nclicks == 1 then
                if button == "l" then vim.cmd "CMakeSelectBuildPreset" end
              end
            end,
            name = "statusline_onclick_cmake_select_build_preset",
          },
          update = "BufEnter",
        },
        status.component.builder {
          provider = function()
            local cmake = require "cmake-tools"
            local b_target = cmake.get_build_target()
            return " [" .. (b_target and b_target or "X") .. "]"
          end,

          padding = { right = 1 },
          condition = is_cmake,
          on_click = {
            --- _self, _minwid, nclicks, button, _mods
            callback = function(_, _, nclicks, button, _)
              if nclicks == 1 then
                if button == "l" then vim.cmd "CMakeSelectBuildTarget" end
              end
            end,
            name = "statusline_onclick_cmake_select_build_target",
          },
          update = "BufEnter",
        },
        status.component.builder {
          provider = function() return " " end,

          surround = { separator = "right", color = utils.get_hlgroup "Comment" },
          condition = is_cmake,
          on_click = {
            --- _self, _minwid, nclicks, button, _mods
            callback = function(_, _, nclicks, button, _)
              if nclicks == 1 then
                if button == "l" then vim.cmd "CMakeDebug" end
              end
            end,
            name = "statusline_onclick_cmake_debug",
          },
          update = "BufEnter",
        },
        status.component.builder {
          provider = function() return "" end,

          padding = { right = 1 },
          condition = is_cmake,
          on_click = {
            --- _self, _minwid, nclicks, button, _mods
            callback = function(_, _, nclicks, button, _)
              if nclicks == 1 then
                if button == "l" then vim.cmd "CMakeRun" end
              end
            end,
            name = "statusline_onclick_cmake_run",
          },
          update = "BufEnter",
        },
        status.component.builder {
          provider = function()
            local cmake = require "cmake-tools"
            local l_target = cmake.get_launch_target()
            return " [" .. (l_target and l_target or "X") .. "]"
          end,

          padding = { right = 1 },
          condition = is_cmake,
          on_click = {
            --- _self, _minwid, nclicks, button, _mods
            callback = function(_, _, nclicks, button, _)
              if nclicks == 1 then
                if button == "l" then vim.cmd "CMakeSelectLaunchTarget" end
              end
            end,
            name = "statusline_onclick_cmake_select_launch_target",
          },
          update = "BufEnter",
        },
      }

      opts.statusline = { -- statusline
        hl = { fg = "fg", bg = "bg" },
        status.component.mode { mode_text = { padding = { left = 1, right = 1 } } }, -- add the mode text
        status.component.git_branch(),
        status.component.file_info { filetype = {}, filename = false, file_modified = false },
        status.component.git_diff(),
        status.component.diagnostics(),
        cmake_status,
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.treesitter(),
        status.component.nav(),
        -- remove the 2nd mode indicator on the right
      }

      return opts
    end,
  },
}
