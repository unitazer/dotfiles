return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "java",
        "hyprlang",
        "rust",
        "c_sharp"
      },
    },
  },

  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      ensure_installed = {
        "wgsl-analyzer",
        "lua-language-server",
        "css-lsp",
        "html-lsp",
        "bash-language-server",
        "docker-compose-language-service",
        "awk-ls",
        "jdtls",
        "java-debug-adapter",
        "nil",
        "clangd",
        "yamlls",
        "glsl_analyzer",
        "hyprls",
        "google-java-format",
        "taplo",
        "xmlformatter",
        "omnisharp",
        "dotnet-format",
        "codelldb",
      },
    },
  },
  {
    "saecki/crates.nvim",

    lazy = true,
    ft = { "rust", "toml" },
    config = function()
      local crates = require "crates"
      crates.setup()
      crates.show()
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.nvimtree",
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function()
      require("gitblame").setup({
        enabled = true,
        message_template = " <summary> • <date> • <author> • <sha>",
        date_format = "%r",
        highlight_group = "Comment",
      })
    end,
  },
}
