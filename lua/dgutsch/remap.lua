vim.g.mapleader = " "

-- <leader>pv now opens oil (see after/plugin/oil.lua); oil disables netrw.

vim.keymap.set("n", "<leader>fj", function()
  local input = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  local output = vim.fn.system({ "jq", "." }, input)
  if vim.v.shell_error ~= 0 then
    vim.notify(output, vim.log.levels.ERROR)
    return
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(vim.trim(output), "\n"))
end, { desc = "Format JSON with jq" })
