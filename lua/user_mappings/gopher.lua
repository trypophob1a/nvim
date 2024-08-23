local gopher = {}
function gopher.setup(map)
  -- gopher
  map("n", "<leader>gsj", "<cmd> GoAddTag json <CR>", { desc = "Golang add json tags" })
  map("n", "<leader>gsrj", "<cmd> GoRmTag json <CR>", { desc = "Golang remove json tags" })
  map("n", "<leader>gtf", "<cmd> GoAddTest <CR>", { desc = "Golang add test for current func" })
  -- Дебаггинг Go тестов
  map("n", "<leader>dgt", function()
    require("dap-go").debug_test()
  end, { desc = "Дебаггинг Go тестов" })

  -- Дебаггинг последнего Go теста
  map("n", "<leader>dgl", function()
    require("dap-go").debug_last()
  end, { desc = "Дебаггинг последнего Go теста" })
end

return gopher
