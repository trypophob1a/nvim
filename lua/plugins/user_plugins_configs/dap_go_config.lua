local dab_go = {}
function dab_go.Setup(_, opts)
  local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
  if is_windows then
    opts.delve = opts.delve or {}
    opts.delve.detached = false
  end
  require("dap-go").setup(opts)
  require("dap").set_log_level "TRACE"
end
return dab_go
