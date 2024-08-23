local Lua_config = {}

function Lua_config.Load(lspconfig, nvlsp)
  lspconfig["lua_ls"].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
return Lua_config
