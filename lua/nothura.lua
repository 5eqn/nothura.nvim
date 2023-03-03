-- get title
local function get_title()
  local aerial = require("aerial")
  local symbols = aerial.get_location(true)

  -- retrieve the last element of symbols
  if #symbols == 0 then
    return
  end
  local symbol = symbols[#symbols]
  local name = symbol.name
  return name
end

-- get current line
local function get_line()
  local line = vim.api.nvim_get_current_line()
  return line
end

-- find first <%path P%page> in given string
local function find_path(str)
  local page, path = string.match(str, "%[P(%d+)%]%((%S+)%)")
  return path, page
end

-- given path and page, run zathura session
local function goto_page(path, page)
  vim.fn.system('nothura-pdf ' .. path .. ' ' .. page)
end

-- get path and page from current line and call zathura
function GotoZathura()
  local line = get_line()
  local path, page = find_path(line)
  -- goto page if path and page are found
  if path and page then
    goto_page(path, page)
  else
    local title = get_title()
    if title then
      local path2, page2 = find_path(title)
      -- goto page if path and page are found
      if path2 and page2 then
        goto_page(path2, page2)
      end
    end
  end
end
