local M = {

  lazy = true,
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
  },
  opts = {},
  keys = {
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle Breakpoint",
    },

    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    {
      "<leader>dC",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },

    {
      "<leader>dT",
      function()
        require("dap").terminate()
      end,
      desc = "Terminate",
    },

    {
      "<leader>dr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle REPL",
    },

    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "Run Last",
    },

    {
      "<leader>ds",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },

    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },

    {
      "<leader>do",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
  },
  config = function()
    local dap = require "dap"
    local ui = require "dapui"
    require("dapui").setup()

    local codelldb_path = vim.fn.stdpath "data" .. "/mason/bin/codelldb"
    dap.adapters.codelldb = {
      type = "executable",
      command = codelldb_path,
      name = "codelldb",
    }

    dap.adapters.java = function(callback)
      callback { type = "server", host = "127.0.0.1", port = 5005 }
    end

    dap.configurations.java = {
      {
        name = "Debug (Attach) - Remote",
        type = "java",
        request = "attach",
        hostName = "127.0.0.1",
        port = 5008,
      },
    }

    dap.configurations.rust = {
      {
        name = "Debug",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = true,
      },
    }
    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
  end,
}
return M
