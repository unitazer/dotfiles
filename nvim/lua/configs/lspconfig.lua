require("nvchad.configs.lspconfig").defaults()

local mason_path = vim.fn.stdpath "data" .. "mason"
local jda_path_pattern = mason_path
  .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"

local servers = {
  html = {}, --defaults
  awk_ls = {},
  bashls = {},
  cssls = {},
  yamlls = {},
  jdtls = {
    cmd = {
      "jdtls",
      "--java-executable",
      "/usr/lib/jvm/java-25-openjdk/bin/java",
    },
    -- init_options = {
    --   bundles = {
    --     vim.fn.glob(jda_path_pattern),
    --   },
    -- },
    filetypes = { "java" },
    root_markets = { ".git", "build.gradle", "." },
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
    on_attach = function()
      require("nvim-tree.view").resize(55)
    end,
  },
  -- scala = {
  --   cmd = { "metals" },
  --   filetypes = { "scala" },
  --   root_markers = { "build.sbt", "build.sc", "build.gradle", "pom.xml" },
  --   init_options = {
  --     statusBarProvider = "show-message",
  --     isHttpEnabled = true,
  --     compilerOptions = {
  --       snippetAutoIndent = false,
  --     },
  --   },
  --   capabilities = {
  --     workspace = {
  --       configuration = false,
  --     },
  --   },
  --   },

  hyprls = {},
  docker_compose_language_service = {},
  glsl_analyzer = { filetypes = { "glsl", "frag" } },
  clangd = {
    filetypes = { "h", "c", "cpp", "cc", "objc", "objcpp" },
    cmd = { "clangd", "--background-index" },
    single_file_support = true,
    root_dir = vim.fs.root(0, { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" }),
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
  ["wgsl_analyzer"] = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = { group = "module" },
          prefix = "self",
        },
        cargo = { buildScripts = { enable = true } },
        procMacro = { enable = true },
        lru = { capacity = 44 },
      },
    },
  },
  ["nil"] = {},
  omnisharp = {
    filetypes = { "cs" },
    root_dir = vim.fs.root(0, { ".csproj", ".sln", ".git" }),
    enable_editorconfig_support = true,
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
  },
}
for name, opts in pairs(servers) do
  vim.lsp.enable(name)
  vim.lsp.config(name, opts)
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.java",
  callback = function()
    local nvimtree_loaded = package.loaded["nvim-tree"] ~= nil
    if nvimtree_loaded then
      vim.cmd("NvimTreeResize 55")
    end
  end,
})


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
