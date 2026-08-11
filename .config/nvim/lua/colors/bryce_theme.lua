-- colors/bryce_dark.lua
-- A compact, VSCode Dark+-like palette derived from the provided screenshot.

local c = {
  -- Base
  bg      = "#1E1E1E",  -- terminal may override; use transparent toggle below
  fg      = "#D4D4D4",
  dim     = "#808080",
  gutter  = "#858585",
  border  = "#3C3C3C",
  cursorl = "#22252A",
  select  = "#264F78",  -- selection bg similar to Dark+

  -- Core hues from the screenshot
  blue    = "#569CD6",  -- keywords / using / namespaces
  yellow  = "#DCDCAA",  -- strings / numbers / some types
  red     = "#F44747",  -- errors
  orange  = "#CE9178",  -- params / fields / attrs
  teal    = "#4EC9B0",  -- methods / calls
  purple  = "#C586C0",  -- other keywords / modifiers
  green   = "#6A9955",  -- comments

  -- Diagnostics & VCS
  err_ul  = "#C74E39",
  info    = "#61AFEF",
  warn    = "#D7BA7D",  -- slightly lighter yellow for warnings
  ok      = "#B5CEA8",
  add     = "#81B88B",
  change  = "#4FC1FF",
  delete  = "#F14C4C",
}

-- Allow transparent background if the user asks for it.
local transparent = vim.g.bryce_dark_transparent == true
local function BG(hex) return transparent and "NONE" or hex end

-- Small helper to define highlights succinctly.
local function hi(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end

-- Reset & declare theme
vim.cmd("highlight clear")
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "bryce_dark"

----------------------------------------------------------------------
-- UI
----------------------------------------------------------------------
hi("Normal",        { fg = c.fg,     bg = BG(c.bg) })
hi("NormalNC",      { fg = c.fg,     bg = BG(c.bg) })
hi("SignColumn",    { fg = c.fg,     bg = BG(c.bg) })
hi("LineNr",        { fg = c.gutter })
hi("CursorLine",    { bg = BG(c.cursorl) })
hi("CursorLineNr",  { fg = c.yellow, bold = true })
hi("VertSplit",     { fg = c.border })
hi("WinSeparator",  { fg = c.border })
hi("StatusLine",    { fg = c.fg,     bg = BG("#111215") })
hi("StatusLineNC",  { fg = c.dim,    bg = BG("#0F1013") })
hi("TabLine",       { fg = c.dim,    bg = BG("#15161A") })
hi("TabLineSel",    { fg = c.fg,     bg = BG(c.cursorl), bold = true })
hi("TabLineFill",   { fg = c.dim,    bg = BG("#141519") })
hi("Pmenu",         { fg = c.fg,     bg = BG("#15181E") })
hi("PmenuSel",      { fg = c.bg,     bg = c.blue })
hi("PmenuSbar",     { bg = BG("#12151A") })
hi("PmenuThumb",    { bg = BG("#2A2E36") })
hi("Visual",        { bg = BG(c.select) })
hi("Search",        { fg = c.bg,     bg = c.yellow })
hi("IncSearch",     { fg = c.bg,     bg = c.orange, bold = true })
hi("MatchParen",    { fg = c.blue,   bold = true, underline = true })
hi("ColorColumn",   { bg = BG("#1A1D22") })
hi("Folded",        { fg = c.dim,    bg = BG("#181B20"), italic = true })
hi("FoldColumn",    { fg = c.dim,    bg = BG("#181B20") })
hi("Whitespace",    { fg = "#2E2E2E" })

----------------------------------------------------------------------
-- Syntax (vimscript groups)
----------------------------------------------------------------------
hi("Comment",       { fg = c.green,  italic = true })
hi("Constant",      { fg = c.yellow })
hi("String",        { fg = c.yellow })
hi("Number",        { fg = c.yellow })
hi("Boolean",       { fg = c.orange })
hi("Identifier",    { fg = c.fg })
hi("Function",      { fg = c.teal })
hi("Statement",     { fg = c.purple })
hi("Operator",      { fg = c.fg })
hi("Keyword",       { fg = c.blue })
hi("Type",          { fg = c.teal })
hi("Special",       { fg = c.orange })
hi("PreProc",       { fg = c.purple })
hi("Todo",          { fg = c.orange, bold = true })
hi("Error",         { fg = c.red, bold = true })

----------------------------------------------------------------------
-- Diagnostics (LSP)
----------------------------------------------------------------------
for _, sev in ipairs({ "Error", "Warn", "Info", "Hint" }) do
  local col = ({ Error=c.red, Warn=c.warn, Info=c.info, Hint=c.ok })[sev]
  hi("Diagnostic"..sev,             { fg = col })
  hi("DiagnosticSign"..sev,         { fg = col, bg = BG(c.bg) })
  hi("DiagnosticVirtualText"..sev,  { fg = col, bg = BG("#181B20") })
  hi("DiagnosticUnderline"..sev,    { sp = col, undercurl = true })
end

----------------------------------------------------------------------
-- Diff / Git
----------------------------------------------------------------------
hi("DiffAdd",       { fg = c.add })
hi("DiffChange",    { fg = c.change })
hi("DiffDelete",    { fg = c.delete })
hi("DiffText",      { fg = c.blue, bold = true })

hi("GitSignsAdd",    { fg = c.add })
hi("GitSignsChange", { fg = c.change })
hi("GitSignsDelete", { fg = c.delete })

----------------------------------------------------------------------
-- Treesitter (common groups)
----------------------------------------------------------------------
local ts = function(name, spec) hi("@"..name, spec) end

ts("comment",               { fg = c.green, italic = true })
ts("string",                { fg = c.yellow })
ts("number",                { fg = c.yellow })
ts("boolean",               { fg = c.orange })
ts("constant",              { fg = c.yellow })
ts("constant.builtin",      { fg = c.yellow })
ts("variable",              { fg = c.fg })
ts("variable.parameter",    { fg = c.orange })
ts("field",                 { fg = c.orange })
ts("property",              { fg = c.orange })
ts("function",              { fg = c.teal })
ts("function.call",         { fg = c.teal })
ts("method",                { fg = c.teal })
ts("constructor",           { fg = c.teal })
ts("type",                  { fg = c.teal })
ts("type.builtin",          { fg = c.teal })
ts("namespace",             { fg = c.blue })
ts("keyword",               { fg = c.blue })
ts("keyword.function",      { fg = c.purple })
ts("operator",              { fg = c.fg })
ts("punctuation",           { fg = c.fg })

-- C#‑leaning tweaks (from the screenshot’s feel)
ts("attribute",             { fg = c.orange })
ts("modifier",              { fg = c.purple })
ts("property.csharp",       { fg = c.orange })

----------------------------------------------------------------------
-- Telescope / Neo-tree / Noice minimal links (if installed)
----------------------------------------------------------------------
hi("TelescopeNormal",       { fg = c.fg,    bg = BG("#14161A") })
hi("TelescopeBorder",       { fg = c.border, bg = BG("#14161A") })
hi("TelescopeSelection",    { fg = c.fg,    bg = BG(c.cursorl) })
hi("NeoTreeNormal",         { fg = c.fg,    bg = BG("#15181E") })
hi("NeoTreeDirectoryName",  { fg = c.blue })
hi("NeoTreeGitAdded",       { fg = c.add })
hi("NeoTreeGitModified",    { fg = c.change })
hi("NeoTreeGitDeleted",     { fg = c.delete })

----------------------------------------------------------------------
-- Terminal ANSI (helps :terminal match the theme)
----------------------------------------------------------------------
vim.g.terminal_color_0  = "#000000"
vim.g.terminal_color_1  = c.red
vim.g.terminal_color_2  = c.green
vim.g.terminal_color_3  = c.yellow
vim.g.terminal_color_4  = c.blue
vim.g.terminal_color_5  = c.purple
vim.g.terminal_color_6  = c.teal
vim.g.terminal_color_7  = c.fg
vim.g.terminal_color_8  = "#666666"
vim.g.terminal_color_9  = c.red
vim.g.terminal_color_10 = c.green
vim.g.terminal_color_11 = c.yellow
vim.g.terminal_color_12 = c.blue
vim.g.terminal_color_13 = c.purple
vim.g.terminal_color_14 = c.teal
vim.g.terminal_color_15 = "#FFFFFF"
