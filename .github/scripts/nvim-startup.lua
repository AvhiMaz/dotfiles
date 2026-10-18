local errors = {}

local notify = vim.notify
vim.notify = function(msg, level, ...)
  if level and level >= vim.log.levels.ERROR then
    errors[#errors + 1] = "notify: " .. tostring(msg)
  end
  return notify(msg, level, ...)
end

vim.defer_fn(function()
  if vim.v.errmsg ~= "" then
    errors[#errors + 1] = "errmsg: " .. vim.v.errmsg
  end

  local messages = vim.api.nvim_exec2("messages", { output = true }).output
  for line in messages:gmatch "[^\n]+" do
    if line:match "^E%d+:" or line:match "Error" then
      errors[#errors + 1] = "message: " .. line
    end
  end

  for _, lhs in ipairs { "<Space>ff", "<Space>e", "<Space>gg", "<Space>a" } do
    if vim.fn.maparg(lhs, "n") == "" then
      errors[#errors + 1] = "missing mapping: " .. lhs
    end
  end

  local stats = require("lazy").stats()
  io.stdout:write(("plugins: %d installed, %d loaded\n"):format(stats.count, stats.loaded))
  for _, e in ipairs(errors) do
    io.stdout:write("ERROR " .. e .. "\n")
  end

  if #errors == 0 then
    io.stdout:write "startup ok\n"
    vim.cmd "qa!"
  else
    io.stdout:write "startup failed\n"
    vim.cmd "cq"
  end
end, 8000)
