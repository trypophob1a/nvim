local options = {
  formatters_by_ft = {
    css = { "prettier" },
    lua = { "stylua" },
    go = {
      -- "goimports-reviser",
      "gofumpt",
      "gomodifytags",
      "goimports",
    },
    html = { "prettier" },
    -- zig = { "zigfmt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 800,
    lsp_fallback = true, -- Форматирование через LSP fallback, если форматтеры отсутствуют
  },
}

-- Настройка автокоманды для GoImports отдельно от таблицы
vim.cmd [[
  autocmd BufWritePost *.go GoImports
]]

return options
