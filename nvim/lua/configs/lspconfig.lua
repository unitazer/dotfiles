require("nvchad.configs.lspconfig").defaults()

local configs = require "nvchad.configs.lspconfig"

local servers = {
  html = {}, --defaults
  awk_ls = {},
  bashls = {},
  cssls = {},
  jsonls = {},
  yamlls = {},
  jdtls = {},
  csharp_ls = {},
  hyprls = {},
  docker_compose_language_service = {},
  glsl_analyzer = {},
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
  }
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  require("lspconfig")[name].setup(opts)
end
