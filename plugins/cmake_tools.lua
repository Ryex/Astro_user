local utils = require "astronvim.utils"
return {
  {
    "Civitasv/cmake-tools.nvim",
    keys = {
      { "<leader>Bc", name = "CMake commands" },
      { "<leader>Bcg", "<cmd>CMakeGenerate<cr>", desc = "Generate CMake config" },
      { "<leader>Bcb", "<cmd>CMakeBuild<cr>", desc = "CMake Build" },
      { "<leader>Bci", "<cmd>CMakeInstall<cr>", desc = "CMake install" },
      { "<leader>Bcr", "<cmd>CMakeRun<cr>", desc = "CMake Run" },
      { "<leader>Bcd", "<cmd>CMakeDebug<cr>", desc = "CMake Debug" },
      { "<leader>Bca", "<cmd>CMakeLaunchArgs<cr>", desc = "Set CMake launch args" },
      { "<leader>Bcs", "<cmd>CMakeStop<cr>", desc = "Stop CMake" },
      { "<leader>Bct", "<cmd>CMakeSelectBuildTarget<cr>", desc = "Select CMake build target" },
      { "<leader>BcT", "<cmd>CMakeSelectLaunchTarget<cr>", desc = "Select Cmake launch target" },
      { "<leader>Bcp", "<cmd>CMakeSelectConfigurePreset<cr>", desc = "Select CMake configure preset" },
      { "<leader>BcP", "<cmd>CMakeSelectBuildBPreset<cr>", desc = "Select Cmake build preset" },
      { "<leader>BcC", "<cmd>CMakeClean<cr>", desc = "CMake Clean" },
      { "<leader>Bco", "<cme>CMakeOpen<cr>", desc = "Open CMake window" },
      { "<leader>Bcq", "<cmd>CMakeClose<cr>", desc = "Close CMake window" },
    },
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astronvim.utils.status"

      local heirline_utils = require "heirline.utils"
      local function is_cmake()
        local buffer_match =
          heirline_utils.buffer_matches { filetype = { "c", "cpp", "objc", "objcpp", "cuda", "proto" } }
        vim.notify(
          "Statusline condition checked! " .. "Filetype " .. vim.bo.filetype .. " buffer match " .. buffer_match,
          vim.log.levels.INFO
        )

        if buffer_match then
            local cmake = require "cmake-tools"
            return cmake.is_cmake_project()
        end
      end


      local function is_cmake_and_preset()
        local buffer_match =
          heirline_utils.buffer_matches { filetype = { "c", "cpp", "objc", "objcpp", "cuda", "proto" } }
        vim.notify(
          "Statusline condition checked! " .. "Filetype " .. vim.bo.filetype .. " buffer match " .. buffer_match,
          vim.log.levels.INFO
        )

        if buffer_match then
            local cmake = require "cmake-tools"
            return cmake.is_cmake_project() and cmake.has_cmake_preset()
        end
      end

      local cmake_status = {
        {
          provider = function()
            local cmake = require "cmake-tools"
            local c_preset = cmake.get_configure_preset()
            return utils.get_icon "Search" .. "CMake: [" .. (c_preset and c_preset or "X") .. "]"
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
          },
          update = "BufEnter",
        },
        {
          provider = function()
            local cmake = require "cmake-tools"
            local type = cmake.get_build_type()
            return utils.get_icon "Search" .. "CMake: [" .. (type and type or "") .. "]"
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
          },
          update = "BufEnter",
        },
        {
          provider = function()
            local cmake = require "cmake-tools"
            local kit = cmake.get_kit()
            return utils.get_icon "Selected" .. "[" .. (kit and kit or "X") .. "]"
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
          },
          update = "BufEnter",
        },
        {
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
          },
          update = "BufEnter",
        },
        {
          provider = function()
            local cmake = require "cmake-tools"
            local b_preset = cmake.get_build_preset()
            return utils.get_icon "Search" .. "[" .. (b_preset and b_preset or "X") .. "]"
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
          },
          update = "BufEnter",
        },
        {
          provider = function()
            local cmake = require "cmake-tools"
            local b_target = cmake.get_build_target()
            return "[" .. (b_target and b_target or "X") .. "]"
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
          },
          update = "BufEnter",
        },
        {
          provider = function() return "" end,

          surround = { separator = "right", color = utils.get_hlgroup "Comment" },
          condition = is_cmake,
          on_click = {
            --- _self, _minwid, nclicks, button, _mods
            callback = function(_, _, nclicks, button, _)
              if nclicks == 1 then
                if button == "l" then vim.cmd "CMakeDebug" end
              end
            end,
          },
          update = "BufEnter",
        },
        {
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
          },
          update = "BufEnter",
        },
        {
          provider = function()
            local cmake = require "cmake-tools"
            local l_target = cmake.get_launch_target()
            return "[" .. (l_target and l_target or "X") .. "]"
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
          },
          update = "BufEnter",
        },
      }


      opts.statusline = { -- statusline
        hl = { fg = "fg", bg = "bg" },
        status.component.mode(),
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
        status.component.mode { surround = { separator = "right" } },
      }

      -- inject_table_after(opts.statusline, cmake_status, first_fill - 1)
      -- table.insert(opts.statusline, first_fill - 1, cmake_status)

      return opts
    end,
  },
}
