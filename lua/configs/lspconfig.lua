-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local relativePath = "lua/configs/user_lspconfigs" -- Относительный путь к директории
local fs = require "utility.fs"
local checker = require "utility.modules_checker"

local util = require "lspconfig/util"
local skip = require("utility.skip_register").Add {}
fs.ReadFilesAsync(relativePath, "Error loading files", function(file)
  file = fs.RemoveLuaExtension(file)
  local success, cfg = pcall(require, "configs.user_lspconfigs." .. file)
  if not success then
    vim.api.nvim_echo({ { "Failed to load module: " .. file, "ErrorMsg" } }, false, {})
    return
  end

  if checker.hasMethod(cfg, "Load") then
    cfg.Load(lspconfig, nvlsp, util)
  end
end, skip)

--
-- lsps with default config
--for _, lsp in ipairs(servers) do
-- lspconfig[lsp].setup {
--  on_attach = nvlsp.on_attach,
-- on_init = nvlsp.on_init,
-- capabilities = nvlsp.capabilities,
-- }
--end
