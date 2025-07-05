require("nvchad.configs.lspconfig").defaults()
local servers = {
  html = {}, --defaults
  awk_ls = {},
  bashls = {},
  cssls = {},
  jsonls = {},
  yamlls = {},
  jdtls = {
    cmd = {
      "jdtls",
      "--java-executable",
      "/usr/lib/jvm/java-21-openjdk/bin/java",
    },
    filetypes = { "java" },
    root_markets = { ".git", "build.gradle", "." },
    on_init = function(_, _)
      require("nvim-tree.view").resize(55) --yes, its that bad
    end,
  },
  -- groovyls = {
  --   filetypes = { "groovy" },
  --   cmd = { "groovy-language-server" },
  --   root_markets = { "build.gradle.kts", ".git", "packwiz", "pack.toml", "." },
  --   settings = {
  --     groovy = {
  --       classpath = {
  --         "build/libs",
  --         "lib/dependency.jar",
  --         "build/rfg/minecraft-src/",
  --         "build/classes",
  --       },
  --     },
  --   },
  -- },
  gooberscript = {
    name = "gooberscript",
    cmd = { "nc", "127.0.0.1", "25564" },
    filetypes = { "groovy" },
    root_markets = { "build.gradle.kts", ".git", "packwiz", "pack.toml", "./" },
    on_init = function()
      require("nvim-tree.view").resize(35)
    end,
  },

  csharp_ls = {},
  hyprls = {},
  docker_compose_language_service = {},
  glsl_analyzer = { filetypes = { "glsl", "frag" } },
  clangd = {
    filetypes = { "h", "c", "cpp", "cc", "objc", "objcpp" },
    cmd = { "clangd", "--background-index" },
    single_file_support = true,
    root_dir = require("lspconfig").util.root_pattern(
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac",
      ".git"
    ),
  },

  dockerls = {
    settings = {
      docker = {
        languageserver = {
          formatter = {
            ignoreMultilineInstructions = true,
          },
        },
      },
    },
  },

  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "basic",
        },
      },
    },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
}
for name, opts in pairs(servers) do
  vim.lsp.enable(name)
  vim.lsp.config(name, opts)
end

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  callback = function()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        return
      end
    end
    vim.diagnostic.open_float {
      scope = "cursor",
      focusable = false,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave",
      },
    }
  end,
})
