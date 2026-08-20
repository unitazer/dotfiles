require "nvchad.mappings"

local map = vim.keymap.set

map("n", "<leader>ps", "i¯\\_(ツ)_/¯<Esc>", { desc = "shrug" })

map("n", "<leader>fd", function()
  require("telescope.builtin").diagnostics()
end, { desc = "Telescope all diagnostics" })

map("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy full file path" })

map("n", "<leader>co", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "Copy relative file path" })

map("n", "<leader>gb", ":GitBlameToggle<CR>", { desc = "Toggle git blame" })
map("n", "<leader>gc", ":GitBlameCopySHA<CR>", { desc = "Copy git blame commit sha" })
map("n", "<leader>gB", ":GitBlameOpenCommitURL<CR>", { desc = "Open git blame commit url" })