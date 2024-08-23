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
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 800,
    vim.cmd [[
       autocmd BufWritePost *.go GoImports
    ]],
    lsp_fallback = true,
  },
}

return options
