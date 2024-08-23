require "nvchad.options"
vim.g.codeium_no_map_tab = 1

vim.api.nvim_set_keymap(
  "i",
  "<C-Space>",
  '<cmd>CocActionAsync("showSignatureHelp")<CR>',
  { noremap = true, silent = true }
)
-- add yours here!
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
