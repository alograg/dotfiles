local fn = vim.fn
local api = vim.api
local fmt = string.format

local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function mode()
  local current_mode = api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
  local current_mode = api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
    mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
    mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "R" then
    mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
    mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
    mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end

local function filepath()
  local fpath = fn.fnamemodify(fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
    return " "
  end

  return string.format(" %%<%s/", fpath)
end

local function filename()
  local fname = fn.expand "%:t"
  if fname == "" then
    return ""
  end
  return fname
end

local function filetype()
  return string.format(" %s ", vim.bo.filetype):upper()
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %#Normal# %l:%c "
end

local function fileencoding()
  local fname = fn.expand "%:t"
  if fname == "" then
    return ""
  end
  return " (%{&fileencoding?&fileencoding:&encoding}) "
end
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
Statusline = {}

Statusline.active = function()
  return table.concat {
    "%#Statusline#",
    update_mode_colors(),
    mode(),
    "%#Normal# ",
    filepath(),
    filename(),
    fileencoding(),
    "%#Normal#",
    "%=%#StatusLineExtra#",
    "%{get(b:,'gitsigns_status','')}",
    filetype(),
    lineinfo(),
  }
end

function Statusline.inactive()
  return " %F"
end

function augroup(name, autocmds, noclear)
  vim.cmd("augroup " .. name)
  if not noclear then
    vim.cmd "autocmd!"
  end
  for _, c in ipairs(autocmds) do
    local command = c.command
    if type(command) == "function" then
      local fn_id = utils.create(command)
      command = fmt("lua utils.execute(%s)", fn_id)
    end
    vim.cmd(
      fmt(
        "autocmd %s %s %s %s",
        table.concat(c.events, ","),
        table.concat(c.targets or {}, ","),
        table.concat(c.modifiers or {}, " "),
        command
      )
    )
  end
  vim.cmd "augroup END"
end

augroup("Statusline", {
  {
    events = { "WinEnter,BufEnter" },
    targets = { "*" },
    command = "setlocal statusline=%!v:lua.Statusline.active()",
  },
  {
    events = { "WinLeave,BufLeave" },
    targets = { "*" },
    command = "setlocal statusline=%!v:lua.Statusline.inactive()",
  },
})
