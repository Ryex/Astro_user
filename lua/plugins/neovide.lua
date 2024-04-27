if not vim.g.neovide then
  return {} -- do nothing if not in a Neovide session
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = { -- configure vim.opt options
        -- configure font
        guifont = "FiraCode Nerd Font:h12",
        -- line spacing
        linespace = 0,
      },
      g = { -- configure vim.g variables
        -- configure scaling
        neovide_scale_factor = 0.85,
        -- configure padding
        neovide_padding_top = 0,
        neovide_padding_bottom = 0,
        neovide_padding_right = 0,
        neovide_padding_left = 0,
        -- shadow
        neovide_floating_shadow = true,
        neovide_floating_z_height = 10,
        neovide_light_angle_degrees = 45,
        neovide_light_radius = 5,
        -- cursor
        neovide_cursor_animation_length = 0.13,
        neovide_cursor_animate_command_line = true,
        neovide_cursor_vfx_mode = "railgun"
      },
    },
  },
}
