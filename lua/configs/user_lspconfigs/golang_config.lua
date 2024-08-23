local Go_config = {}

function Go_config.Load(lspconfig, nvlsp, util)
  lspconfig["gopls"].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        -- completeUnimported = true,  -- Раскомментируйте эту строку, если нужно
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  }
end
return Go_config
