-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- colorscheme
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.dracula-nvim" },
  { import = "astrocommunity.colorscheme.helix-nvim" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  -- lang packs
  { import = "astrocommunity.pack.cmake" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.tailwindcss" },
  -- { import = "astrocommunity.pack.ruby" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.ps1" },
  -- { import = "astrocommunity.pack.java" },
  -- { import = "astrocommunity.pack.kotlin" },
  { import = "astrocommunity.pack.markdown" },
  -- { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.prisma" },
  { import = "astrocommunity.pack.docker" },
  -- { import = "astrocommunity.pack.full-dadbod" },
  -- language support
  { import = "astrocommunity.programming-language-support.csv-vim" },
  { import = "astrocommunity.programming-language-support.nvim-jqx" },

  -- recipes
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  -- { import = "astrocommunity.recipes.heirline-nvchad-statusline" },

  -- completion
  { import = "astrocommunity.completion.cmp-cmdline" },

  -- diagnostics
  { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.diagnostics.error-lens-nvim" },
  -- debugging
  { import = "astrocommunity.debugging.nvim-bqf" },
  -- { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  -- { import = "astrocommunity.debugging.persistent-breakpoints-nvim" },
  -- project
  { import = "astrocommunity.project.nvim-spectre" },
  -- {
  --   "nvim-pack/nvim-spectre",
  --   opts = {
  --     replace_engine = {
  --       ["sed"] = {
  --         args = {
  --           "-b",
  --         },
  --       },
  --     },
  --     default = {
  --       replace = {
  --         cmd = "sed",
  --       },
  --     },
  --   },
  -- },

  -- git
  { import = "astrocommunity.git.git-blame-nvim" },
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.git.neogit" },
  { import = "astrocommunity.git.octo-nvim" },
  -- editing
  { import = "astrocommunity.editing-support.multicursors-nvim" },

  -- { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  -- { import = "astrocommunity.editing-support.text-case-nvim" },
  { import = "astrocommunity.editing-support.nvim-regexplainer" },
  -- runners
  { import = "astrocommunity.code-runner.compiler-nvim" },
  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.code-runner.sniprun" },
  -- color
  { import = "astrocommunity.color.headlines-nvim" },
  { import = "astrocommunity.color.nvim-highlight-colors" },
  -- { import = "astrocommunity.color.vim-highlighter" },
  -- indent
  -- { import = "astrocommunity.indent.indent-blankline-nvim" },
  -- { import = "astrocommunity.indent.mini-indentscope" },
  -- lsp
 -- { import = "astrocommunity.lsp.delimited-nvim" },
  -- { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.lsp.lsp-inlayhints-nvim" }, -- remove for nvim 0.10
  { import = "astrocommunity.lsp.lsp-lens-nvim" },
  { import = "astrocommunity.lsp.inc-rename-nvim" },
  -- { import = "astrocommunity.lsp.garbage-day-nvim" },
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
  { import = "astrocommunity.lsp.lsplinks-nvim" },
  -- motion
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  -- { import = "astrocommunity.motion.vim-matchup" },
  -- scrolling
  -- { import = "astrocommunity.scrolling.cinnamon-nvim" },
  -- { import = "astrocommunity.scrolling.mini-animate" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  -- utility
  -- {
  --   import = "astrocommunity.utility.noice-nvim",
  -- },

  -- {
  --   "folke/noice.nvim",
  --   opts = function(_, opts)
  --     return utils.extend_tbl(opts, {
  --       lsp = {
  --         signature = {
  --           enabled = true,
  --         },
  --       },
  --     })
  --   end,
  -- },
}
