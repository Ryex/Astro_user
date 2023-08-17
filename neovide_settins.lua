local neovide_user = {}

function neovide_user.setNeovideSettings()
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
  -- local alpha = function() return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8))) end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 1.0
  vim.g.transparency = 1.0
  vim.g.neovide_window_floating_opacity = 1.0
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

return neovide_user
