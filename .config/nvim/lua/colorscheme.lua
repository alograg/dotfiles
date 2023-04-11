local scheme = {
  fg = "#EEFFFF",
  bg = "#131519",
  accent = "#F07178",
  lightbg = "#263238",
  linebg = "#263238",
  fgfaded = "#546E7A",
  grey = "#42464e",
  light_grey = "#6f737b",
  dark_grey = "#1b1d23",
  bright = "#FFFFFF",
  red = "#F07178",
  green = "#C3E88D",
  blue = "#82AAFF",
  yellow = "#FFCB6B",
  magenta = "#C792EA",
  orange = "#d19a66",
  cyan = "#89DDFF",
  ViMode = {},
}

vim.cmd("hi StatusLineAccent guifg=" .. scheme.bg .. " guibg=" .. scheme.accent or scheme.magenta)
vim.cmd("hi StatusLineInsertAccent guifg=" .. scheme.bg .. " guibg=" .. scheme.red)
vim.cmd("hi StatusLineVisualAccent guifg=" .. scheme.bg .. " guibg=" .. scheme.green)
vim.cmd("hi StatusLineReplaceAccent guifg=" .. scheme.bg .. " guibg=" .. scheme.red)
vim.cmd("hi StatusLineCmdLineAccent guifg=" .. scheme.bg .. " guibg=" .. scheme.yellow)
vim.cmd("hi StatuslineTerminalAccent guifg=" .. scheme.bg .. " guibg=" .. scheme.yellow)
vim.cmd("hi StatusLineExtra guifg=" .. scheme.fgfaded)
vim.cmd("hi StatusLineNC guibg=NONE")

vim.cmd("hi CursorLineNr guibg=" .. scheme.lightbg)
