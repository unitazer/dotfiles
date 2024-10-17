local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")

lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html" },
})
lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "css", "scss", "less" },
})
lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "json", "jsonc" },
})
lspconfig.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "yaml" },
})

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        diagnosticSeverityOverrides = {
          reportOptionalSubscript = "information",
          reportOptionalMemberAccess = "none",
        },
        typeCheckingMode = "off",
        useLibraryCodeForTypes = true,
      }
    }
  }

})

lspconfig.bashls.setup({})
lspconfig.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

lspconfig.docker_compose_language_service.setup {}

lspconfig.dockerls.setup {
  settings = {
    docker = {
      languageserver = {
        formatter = {
          ignoreMultilineInstructions = true,
        },
      },
    }
  }
}
lspconfig.csharp_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "cs", "vb" },
}
lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "h", "c", "cpp", "cc", "objc", "objcpp" },
  cmd = { "clangd", "--background-index" },
  single_file_support = true,
  root_dir = lspconfig.util.root_pattern(
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    '.git'
  )
})
lspconfig.cmake.setup {}
lspconfig.arduino_language_server.setup { on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { ".ino" },

  cmd = {
    "arduino-language-server",
    "-cli-config",
    "$HOME/.config/.arduino15/arduino-cli.yaml", }
}
