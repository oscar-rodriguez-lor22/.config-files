vim.cmd.colorscheme("tokyonight")

if vim.api.nvim_get_option('colorscheme')  == 'tokyonight' then
	print("Tokyo-Night Theme Applied")
else
	print("ERROR: Tokyo-Night THEME NOT APPLIED!")
end
