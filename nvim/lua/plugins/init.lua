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
      },
    },
  },

  {
    "williamboman/mason.nvim",
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
        "json-lsp",
        "docker-compose-language-service",
        "awk-ls",
        "csharp-ls",
        "jdtls",
        "java-debug-adapter",
        "nil",
        "clangd",
        "yamlls",
        "glsl_analyzer",
        "hyprls",
        "google-java-format",
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
}
