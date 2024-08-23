require "nvchad.mappings"
-- add yours here

local map = vim.keymap.set
local relativePath = "lua/user_mappings" -- Относительный путь к директории
local fs = require "utility.fs"
local checker = require "utility.modules_checker"
local skip_register = require "utility.skip_register"
skip_register.Add {}

fs.ReadFilesAsync(relativePath, "Error loading files", function(file)
  file = fs.RemoveLuaExtension(file)
  local success, cfg = pcall(require, "user_mappings." .. file)

  if not success then
    vim.api.nvim_echo({ { "Failed to load module: " .. file, "ErrorMsg" } }, false, {})
    return
  end

  if checker.hasMethod(cfg, "setup") then
    cfg.setup(map)
  end
end, skip_register)
