--             USE EXAMPLE:
-- local relativePath = "lua/configs/user_lspconfigs" -- Относительный путь к директории
-- local fs = require "utility.fs"
-- local checker = require "utility.module_checker"

-- fs.ReadFilesAsync(relativePath, "Error loading files", function(file)
--  file = fs.RemoveLuaExtension(file)
--  local success, cfg = pcall(require, "configs.user_lspconfigs." .. file)

--  if not success then
--    vim.api.nvim_echo({ { "Failed to load module: " .. file, "ErrorMsg" } }, false, {})
--    return
--  end

--  if checker.hasMethod(cfg, "Load") then
--    cfg.Load(lspconfig, nvlsp)
--  end
-- end)

-- IF YOU WANT SKIP ANY FILES THEN USE skip_register

-- local skip_register = require "utility.skip_register"
-- skip_register.Add {"example1.lua", "example2.lua", "etc.lua"}
--
-- fs.ReadFilesAsync(relativePath, "Error loading files", function(file)
--  file = fs.RemoveLuaExtension(file)
--  local success, cfg = pcall(require, "configs.user_lspconfigs." .. file)

--  if not success then
--    vim.api.nvim_echo({ { "Failed to load module: " .. file, "ErrorMsg" } }, false, {})
--    return
--  end

--  if checker.hasMethod(cfg, "Load") then
--    cfg.Load(lspconfig, nvlsp)
--  end
-- end, skip_register)

local fs = {}

function fs.getConfigDir()
  local system = package.config:sub(1, 1) == "/" and "unix" or "windows"
  if system == "unix" then
    local homeDir = os.getenv "HOME"
    return homeDir .. "/.config/nvim"
  elseif system == "windows" then
    local localAppData = os.getenv "LOCALAPPDATA" -- Это указывает на Local
    return localAppData .. "\\nvim"
  else
    error "Unsupported platform"
  end
end

function fs.getDirectoryListingStream(configDir, path, errorMsg)
  local system = package.config:sub(1, 1) == "/" and "unix" or "windows"

  local function getFiles(command, sep)
    path = configDir .. sep .. path

    local popen = io.popen
    local pfile = popen(command .. ' "' .. path .. '"')

    if not pfile then
      vim.api.nvim_echo({ { errorMsg .. " path not found: " .. path, "ErrorMsg" } }, false, {})
      return {}
    end
    return pfile
  end

  return system == "unix" and getFiles("ls -a", "/") or getFiles("dir /b", "\\")
end

function fs.GetFilesInDirectory(path, errorMsg)
  local success, configDir = pcall(fs.getConfigDir)
  if not success then
    vim.api.nvim_echo({ { "Error getting config dir: " .. tostring(configDir), "ErrorMsg" } }, false, {})
    return {}
  end

  -- path = configDir .. "/" .. path

  -- local popen = io.popen
  -- local pfile = popen('ls -a "' .. path .. '"')
  -- if not pfile then
  -- vim.api.nvim_echo({ { errorMsg .. " path not found: " .. path, "ErrorMsg" } }, false, {})
  -- return {}
  -- end
  local pfile = fs.getDirectoryListingStream(configDir, path, errorMsg)
  local files = {}
  for filename in pfile:lines() do
    if filename ~= "." and filename ~= ".." then
      table.insert(files, filename)
    end
  end
  pfile:close()
  return files
end

local checker = require "utility.modules_checker"

function fs.ReadFilesAsync(path, errorMsg, callback, skip_register)
  local files = fs.GetFilesInDirectory(path, errorMsg)
  local needSkip
  for _, file in ipairs(files) do
    needSkip = checker.hasMethod(skip_register, "Contains") and skip_register.Contains(file) or false

    if not needSkip then
      vim.schedule(function()
        callback(file)
      end)
    end
  end
end

function fs.RemoveLuaExtension(filename)
  if filename:match "%.lua$" then
    return filename:sub(1, -5) -- Удаляет последние 4 символа ".lua"
  else
    return filename
  end
end

return fs
