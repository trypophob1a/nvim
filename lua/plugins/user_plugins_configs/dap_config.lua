local dap = require "dap"

dap.adapters.gdb = {
  type = "executable",
  command = "gdb", -- или путь к gdb, если он не в PATH
  name = "gdb",
}

dap.configurations.asm = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
    args = {},
    runInTerminal = true,
  },
}
