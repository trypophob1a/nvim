-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "kanagawa",
  transparency = true,
  theme_toggle = { "kanagawa", "one_light" },
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}
M.ui = {
  theme = "kanagawa",
  transparency = true,
  statusline = {
    theme = "vscode_colored",
    order = {
      "mode",
      "file",
      "git",
      "%=",
      "lsp_msg",
      "%=",
      "diagnostics",
      "treesitter_status",
      "codeium_status",
      "lsp",
      "cursor",
      "cwd",
    },
    modules = {
      vim.cmd "highlight MyModulesStatus guifg=#00ff00 guibg=NONE gui=bold",
      treesitter_status = function()
        local active = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] and "" or ""
        return "%#MyModulesStatus#" .. active .. "%*"
      end,
      codeium_status = function()
        local status = vim.fn["codeium#GetStatusString"]()
        -- print("Raw status:", status) -- Добавлено логгирование
        status = vim.fn.trim(status)
        -- print("Trimmed status:", status) -- Дополнительное логгирование или не логгирование
        if string.match(status, "%d+/%d+") then
          return "%#MyModulesStatus# 󰘦 %*"
        elseif status == "0" then
          return "%#MyModulesStatus# 🤔%*"
        elseif status == "*" then
          return "%#MyModulesStatus# ⏳%*"
        elseif status == "ON" then
          return "%#MyModulesStatus# 󰘦 %*"
        elseif status == "OFF" then
          return "%#MyModulesStatus# ❌%*"
        elseif vim.g.s_api_key == "" then
          return "%#MyModulesStatus# 🔒%*"
        else
          return ""
        end
      end,
    },
  },
  nvdash = {
    load_on_startup = true,
  },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    DiffChange = {
      bg = "#464414",
      fg = "none",
    },
    DiffAdd = {
      bg = "#103507",
      fg = "none",
    },
    DiffRemoved = {
      bg = "#461414",
      fg = "none",
    },
  },
}

return M
