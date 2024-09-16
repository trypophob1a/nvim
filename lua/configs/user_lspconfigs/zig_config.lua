local zig = {}

function zig.Load(lspconfig, nvlsp, util)
  lspconfig["zls"].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    cmd = { "zls" },
    filetypes = { "zig", "zon" },
    root_dir = util.root_pattern("zls.json", "build.zig", ".git"),
  }
end

return zig
