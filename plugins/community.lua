return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of importing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
  -- colorscheme
  -- { import = "astrocommunity.colorscheme.catppuccin" },
  -- packs
  { import = "astrocommunity.pack.cmake" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.typescript" },
  -- { import = "astrocommunity.pack.ruby" },
  { import = "astrocommunity.pack.go"} ,
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.ps1" },
  -- { import = "astrocommunity.pack.java" },
  -- { import = "astrocommunity.pack.kotlin" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.prisma" },
  { import = "astrocommunity.pack.docker" },
  -- { import = "astrocommunity.pack.full-dadbod" },
  -- language support
  { import = "astrocommunity.programming-language-support.csv-vim" },
  { import = "astrocommunity.programming-language-support.nvim-jqx" },

  -- completion
  { import = "astrocommunity.completion.cmp-cmdline"},

  -- diagnostics
  { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- debugging
  { import = "astrocommunity.debugging.nvim-bqf" },
  -- { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  -- { import = "astrocommunity.debugging.persistent-breakpoints-nvim" },
  -- project
  { import = "astrocommunity.project.nvim-spectre" },
  -- { import = "astrocommunity.project.projectmgr-nvim" }, -- seems to be mis configured
  -- git
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.git.git-blame-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.git.neogit" },
  -- editing
  { import = "astrocommunity.editing-support.multicursors-nvim" },
  -- { import = "astrocommunity.editing-support.dial-nvim" },
  -- { import = "astrocommunity.editing-support.neogen" },
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
  -- { import = "astrocommunity.color.modes-nvim" },
  { import = "astrocommunity.color.headlines-nvim" },
  -- bars and lines
  { import = "astrocommunity.bars-and-lines.heirline-vscode-winbar" },
  -- indent
  { import = "astrocommunity.indent.indent-blankline-nvim" },
  { import = "astrocommunity.indent.mini-indentscope" },
  -- lsp
  -- { import = "astrocommunity.lsp.lsp-inlayhints-nvim" },
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.lsp.inc-rename-nvim" },
  -- motion
  { import = "astrocommunity.motion.hop-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  -- { import = "astrocommunity.motion.vim-matchup" },
  -- scrolling
  -- { import = "astrocommunity.scrolling.cinnamon-nvim" },
  { import = "astrocommunity.scrolling.mini-animate" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  -- utility
  -- { import = "astrocommunity.utility.noice-nvim" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
}
