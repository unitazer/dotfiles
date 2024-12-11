-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "flexoki",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}
M.ui = {
  tabufline = {
    overriden_modules = function(modules)
      table.insert(modules, modules[1])
      table.remove(modules, 1)
    end,
  }, --https://github.com/NvChad/ui/issues/68 does not fucking work
}
return M
