local dap = require "dap"
function dap.setup(map)
  -- Добавление точки останова
  map(
    "n",
    "<leader>db",
    dap.toggle_breakpoint,
    { desc = "Добавить точку останова на строке" }
  )

  -- Запуск отладки
  map("n", "<leader>dc", dap.continue, { desc = "Запуск отладки" })
  map(
    "n",
    "<leader>du",
    "<cmd>lua require'dapui'.toggle()<CR>",
    { desc = "Открыть панель отладки" }
  )
end
return dap
