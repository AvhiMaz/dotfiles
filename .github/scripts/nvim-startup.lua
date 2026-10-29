local errors = {}

local notify = vim.notify
vim.notify = function(msg, level, ...)
  if level and level >= vim.log.levels.ERROR then
    errors[#errors + 1] = "notify: " .. tostring(msg)
  end
  return notify(msg, level, ...)
end

local function check()
  local langs = {
    "vim", "lua", "vimdoc", "query",
    "html", "css",
    "rust", "toml",
    "json", "javascript", "typescript", "tsx",
    "markdown", "markdown_inline",
    "c", "cpp", "bash", "yaml",
  }
  for _, lang in ipairs(langs) do
    local ok, added = pcall(vim.treesitter.language.add, lang)
    if not ok or not added then
      errors[#errors + 1] = "parser does not load: " .. lang
    elseif not vim.treesitter.query.get(lang, "highlights") then
      errors[#errors + 1] = "no highlight query: " .. lang
    end
  end

  for ext, body in pairs { lua = "local x = 1\n", md = "# title\n\ntext\n" } do
    local path = vim.fn.tempname() .. "." .. ext
    vim.fn.writefile(vim.split(body, "\n"), path)
    vim.cmd.edit(path)
    local buf = vim.api.nvim_get_current_buf()
    if not vim.treesitter.highlighter.active[buf] then
      errors[#errors + 1] = "no treesitter highlighting in a ." .. ext .. " file"
    end
  end

  vim.cmd "checkhealth lazy"
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    if line:match "ERROR" then
      errors[#errors + 1] = "checkhealth lazy: " .. vim.trim(line)
    end
  end

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
  local parsers = require("nvim-treesitter.config").get_installed "parsers"
  io.stdout:write(("parsers: %d installed\n"):format(#parsers))
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
end

local building = { ["tree-sitter"] = true, cc = true, gcc = true, clang = true, curl = true, tar = true }

local function busy()
  for _, pid in ipairs(vim.api.nvim_get_proc_children(vim.fn.getpid())) do
    local proc = vim.api.nvim_get_proc(pid)
    if proc and building[proc.name] then
      return true
    end
  end
  return false
end

local idle, started = 0, vim.uv.now()
local timer = vim.uv.new_timer()
timer:start(2000, 500, vim.schedule_wrap(function()
  idle = busy() and 0 or idle + 1
  if idle >= 6 or vim.uv.now() - started > 300000 then
    timer:stop()
    check()
  end
end))
