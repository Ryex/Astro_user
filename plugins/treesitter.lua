return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "andymass/vim-matchup",
        init = function() vim.g.matchup_matchparen_deferred = 1 end,
      },
      "ChristianChiarulli/nvim-ts-rainbow"
    },
    opts = {
      auto_install = vim.fn.executable "tree-sitter" == 1,
      ensure_installed = {
        "lua", "luadoc", "cpp", "python", "rust", "comment", "toml", "json", "cmake", "git_config",
        "git_rebase", "gitattributes", "gitcommit", "gitignore", "diff", "yaml", "markdown",
        "markdown_inline", "regex", "go", "gomod", "gosum", "typescript", "javascript", "http",
        "css"
      },

      matchup = {
        enable = true,
      },
      highlight = {
        disable = {},
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = true, disable = {} },
      incremental_selection = { enable = true },
      rainbow = { enable = true, extended_mode = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            aA = "@attribute.outer",
            iA = "@attribute.inner",
            aB = "@block.outer",
            iB = "@block.inner",
            aD = "@conditional.outer",
            iD = "@conditional.inner",
            aF = "@function.outer",
            iF = "@function.inner",
            aL = "@loop.outer",
            iL = "@loop.inner",
            aP = "@parameter.outer",
            iP = "@parameter.inner",
            aR = "@regex.outer",
            iR = "@regex.inner",
            aX = "@class.outer",
            iX = "@class.inner",

            aS = "@statement.outer",
            iS = "@statement.outer",
            aN = "@number.inner",
            iN = "@number.inner",
            aC = "@comment.outer",
            iC = "@comment.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]b"] = { query = "@block.outer", desc = "Next block start" },
            ["]f"] = { query = "@function.outer", desc = "Next function start" },
            ["]p"] = { query = "@parameter.outer", desc = "Next parameter start" },
            ["]x"] = { query = "@class.outer", desc = "Next class start" },
            ["]c"] = { query = "@comment.outer", desc = "Next comment start" },
          },
          goto_next_end = {
            ["]B"] = { query = "@block.outer", desc = "Next block end" },
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
            ["]P"] = { query = "@parameter.outer", desc = "Next parameter end" },
            ["]X"] = { query = "@class.outer", desc = "Next class end" },
            ["]C"] = { query = "@comment.outer", desc = "Next comment end" },
          },
          goto_previous_start = {
            ["[b"] = { query = "@block.outer", desc = "Previous block start" },
            ["[f"] = { query = "@function.outer", desc = "Previous function start" },
            ["[p"] = { query = "@parameter.outer", desc = "Previous parameter start" },
            ["[x"] = { query = "@class.outer", desc = "Previous class start" },
            ["[c"] = { query = "@comment.outer", desc = "Previous comment start" },
          },
          goto_previous_end = {
            ["[B"] = { query = "@block.outer", desc = "Previous block end" },
            ["[F"] = { query = "@function.outer", desc = "Previous function end" },
            ["[P"] = { query = "@parameter.outer", desc = "Previous parameter end" },
            ["[X"] = { query = "@class.outer", desc = "Previous class end" },
            ["[C"] = { query = "@comment.outer", desc = "Previous comment end" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            [">B"] = { query = "@block.outer", desc = "Swap next block" },
            [">F"] = { query = "@function.outer", desc = "Swap next function" },
            [">P"] = { query = "@parameter.inner", desc = "Swap next parameter" },
          },
          swap_previous = {
            ["<B"] = { query = "@block.outer", desc = "Swap previous block" },
            ["<F"] = { query = "@function.outer", desc = "Swap previous function" },
            ["<P"] = { query = "@parameter.inner", desc = "Swap previous parameter" },
          },
        },
        lsp_interop = {
          enable = true,
          border = "single",
          peek_definition_code = {
            ["<leader>lp"] = { query = "@function.outer", desc = "Peek function definition" },
            ["<leader>lP"] = { query = "@class.outer", desc = "Peek class definition" },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  },
  {
    "ziontee113/syntax-tree-surfer",
    event = "BufRead",
    module = "syntax-tree-surfer",
    after = "nvim-treesitter",
    config = function()
      require("syntax-tree-surfer").setup {}

      local opts = { noremap = true, silent = true }

      -- Normal Mode Swapping:
      -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
      vim.keymap.set("n", "vU", function()
        vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
        return "g@l"
      end, { silent = true, expr = true })
      vim.keymap.set("n", "vD", function()
        vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
        return "g@l"
      end, { silent = true, expr = true })

      -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
      vim.keymap.set("n", "vd", function()
        vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
        return "g@l"
      end, { silent = true, expr = true })
      vim.keymap.set("n", "vu", function()
        vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
        return "g@l"
      end, { silent = true, expr = true })

      -- Visual Selection from Normal Mode
      vim.keymap.set("n", "vx", "<cmd>STSSelectMasterNode<cr>", opts)
      vim.keymap.set("n", "vn", "<cmd>STSSelectCurrentNode<cr>", opts)

      -- Select Nodes in Visual Mode
      vim.keymap.set("x", "J", "<cmd>STSSelectNextSiblingNode<cr>", opts)
      vim.keymap.set("x", "K", "<cmd>STSSelectPrevSiblingNode<cr>", opts)
      vim.keymap.set("x", "H", "<cmd>STSSelectParentNode<cr>", opts)
      vim.keymap.set("x", "L", "<cmd>STSSelectChildNode<cr>", opts)

      -- Swapping Nodes in Visual Mode
      vim.keymap.set("x", "<A-j>", "<cmd>STSSwapNextVisual<cr>", opts)
      vim.keymap.set("x", "<A-k>", "<cmd>STSSwapPrevVisual<cr>", opts)
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
}
