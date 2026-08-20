---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "flexoki",
}

M.plugins = {
  remove = {
    "nvim-cmp",
    "cmp_luasnip",
  },
}

return M
