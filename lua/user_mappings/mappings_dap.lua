local dap = {}
function dap.setup(map)
  -- Добавление точки останова
  map(
    "n",
    "<leader>db",
    "<cmd>DapToggleBreakpoint<CR>",
    { desc = "Добавить точку останова на строке" }
  )

  -- Открытие панели отладки
  map("n", "<leader>dus", function()
    local widgets = require "dap.ui.widgets"
    local sidebar = widgets.sidebar(widgets.scopes)
    sidebar.open()
  end, { desc = "Открыть панель отладки" })
end
return dap
