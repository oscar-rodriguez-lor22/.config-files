-- ===============================================
-- 1. Imports
require('plugins')
require('theme')
local todo = require('todo')
todo.setup({
	target_file = "~/todo.md" 
})

-- ===============================================
-- 2. General Settings
-- ===============================================

-- Translate Vimscript 'set' commands to vim.opt.* = value
vim.opt.termguicolors = true 
vim.opt.number = true
vim.opt.relativenumber = true

-- Message
print("init.lua ran, no issues")
-- Test --
vim.g.python3_host_prog = '/home/oscar/Dev/GitHub/NIHSearch.nvim/venv/bin/python'
