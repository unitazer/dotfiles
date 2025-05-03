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
    on_init = function (_,_)
      require("nvim-tree.view").resize(55) --yes, its that bad
    end
  },
  gooberscript = {
    name = "gooberscript",
    cmd = { "nc", "127.0.0.1", "25564" },
    filetypes = { "groovy" },
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
