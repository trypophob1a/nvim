local N = {}
function N.setup(map)
  -- Основные настройки клавиш
  map("n", ";", ":", { desc = "CMD enter command mode" })
  map("i", "jj", "<ESC>")
end

return N
