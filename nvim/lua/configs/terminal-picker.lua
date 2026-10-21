local M = {}

function M.pick()
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local state = require "telescope.actions.state"

  local items, max = {}, 0
  for _, term in ipairs(Snacks.terminal.list()) do
    local id = vim.b[term.buf].snacks_terminal.id
    max = math.max(max, id)
    table.insert(items, { id = id, title = vim.b[term.buf].term_title or "" })
  end
  table.sort(items, function(a, b) return a.id < b.id end)
  table.insert(items, { id = max + 1, title = "+ new terminal", new = true })

  pickers.new({}, {
    prompt_title = "Terminals",
    finder = finders.new_table {
      results = items,
      entry_maker = function(item)
        local display = item.new and item.title or (item.id .. "  " .. item.title)
        return { value = item, display = display, ordinal = display }
      end,
    },
    sorter = conf.generic_sorter {},
    attach_mappings = function(buf)
      actions.select_default:replace(function()
        local item = state.get_selected_entry().value
        actions.close(buf)
        Snacks.terminal.toggle(nil, { count = item.id })
      end)
      return true
    end,
  }):find()
end

return M
