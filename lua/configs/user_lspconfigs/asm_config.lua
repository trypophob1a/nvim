local asm_cfg = {}

function asm_cfg.Load(lspconfig, nvlsp, util)
  lspconfig["asm_lsp"].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    cmd = { "asm-lsp" },
    filetypes = { "asm", "s", "S" },
    root_dir = util.root_pattern ".git",
  }
end

return asm_cfg
