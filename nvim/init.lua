local map = require("map")

-- Set Map Leader
vim.g.mapleader = "'"

-- Keyboard mappings
nmap(";",":")
vmap(";",":")

-- Toggle line numbers
function ToggleLineNumbers()
    if vim.w.lineNumbering == nil then
        vim.w.lineNumbering = "absolute"
    elseif vim.w.lineNumbering == "absolute" then
        vim.w.lineNumbering = "relative"
    elseif vim.w.lineNumbering == "relative" then
        vim.w.lineNumbering = nil
    end

    if vim.w.lineNumbering == nil then
        vim.wo.number = false
        vim.wo.relativenumber = false
    elseif vim.w.lineNumbering == "absolute" then
        vim.wo.number = true
        vim.wo.relativenumber = false
    elseif vim.w.lineNumbering == "relative" then
        vim.wo.number = true
        vim.wo.relativenumber = true
    end
end

vim.fn.ToggleLineNumbers = ToggleLineNumbers

-- Word Processor Mode
function WordProcessorMode()
	if vim.g.writing then
		vim.g.writing = false
		vim.wo.spell = false
		vim.cmd("Goyo!")
	else 
		vim.g.writing = true
		vim.bo.textwidth = 0
		vim.bo.smartindent = true
		vim.wo.spell = true
		vim.bo.spelllang = "en_us"
		vim.bo.expandtab = false
		--Might have to figure out word count again?
		--vim.wo.statusline = "%{WordCount()} words"
		vim.wo.number = false
		vim.wo.wrap = true
		vim.wo.linebreak = true
		vim.wo.list = false
		vim.cmd("Goyo")
	end
end

vim.api.nvim_create_user_command("Writing", WordProcessorMode, {nargs = 0})


--[[
vim.opt.statusline = { "%1*" } -- Highlight???
vim.opt.statusline:append { "%<%F" } -- File Name, cut if needed at start
vim.opt.statusline:append { "%M" } -- Modified flag
vim.opt.statusline:append { "%y" } -- file type
vim.opt.statusline:append { "%=" } -- seperator from left to right, justified
vim.opt.statusline:append { " %l/%L lines, %P " } -- Percentage through file.
--]]

vim.o.laststatus = 2 --When should windows have a status line (2 = always)
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.tabstop = 4  -- Number of spaces that a tab counts for. 
vim.o.softtabstop = 4 -- Kinda like tab stop but different
vim.o.shiftwidth = 4 -- Number of spaces to use for auto indent.
vim.o.autoindent = true -- Copy indent from current line to next line.
vim.o.textwidth = 0 -- I'm sick of having to undo text wrap when it breaks things
vim.o.incsearch = true -- Show live highlighting of current search
vim.o.ignorecase = true -- Ignore case when searching
vim.o.smartcase = true -- Do NOT ignore case if search contains uppercase letters.
vim.o.scrolloff = 5 -- How much space you should have at the bottom of the screen
vim.o.wildmode = "full" -- Completion basically.
vim.o.wrapmargin = 0 -- When to begin wrapping lines.
vim.o.colorcolumn = "-10,0" -- Highlight columns relative to text width.
vim.o.showcmd = true -- Show command in the last line of the screen. No idea what this does.
vim.o.list = true -- show tabs as characters

-- Disable all autocommenting tbh
vim.opt.formatoptions:remove { 'c', 'o', 'r' }

-- Tags file
vim.o.tags = "./tags;"

-- PLUGINS
require("plugins")
require("plugin-setup")

-- KEYBINDS
require("keybinds")

-- LSP
require("lsp")

-- THEME
vim.cmd 'colorscheme carvedwood'
