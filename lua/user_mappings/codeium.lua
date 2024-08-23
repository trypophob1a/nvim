local codeium = {}
function codeium.setup(map)
  map("i", "<C-g>", function()
    return vim.fn["codeium#Accept"]()
  end, { expr = true, desc = "Codeium Accept" })

  map("i", "<M-\\>", function()
    return vim.fn["codeium#Complete"]()
  end, { expr = true, desc = "Manually trigger suggestion" })

  map({ "n", "i", "v" }, "<C-\\>", function()
    return vim.fn["codeium#Chat"]()
  end, { expr = true, desc = "Codeium Chat open" })
end
return codeium
