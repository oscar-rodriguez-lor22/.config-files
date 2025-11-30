" vim-plug pulggin manager

" .Vim
call plug#begin()

	"Utilities
	Plug 'nvim-neo-tree/neo-tree.nvim' 			"File tree
	Plug 'norcalli/nvim-colorizer.lua'			"Displays hex code colors when typed 
	Plug 'folke/which-key.nvim'				"Shortcut reference
	Plug 'nvim-telescope/telescope.nvim'			"Modern fuzzy finder
	Plug 'MeanderingProgrammer/render-markdown.nvim'	"Renders md files in buffer

	"Fonts, Icons, Status Lines, & ColorSheme
	Plug 'nvim-tree/nvim-web-devicons'			"Dev icons
	Plug 'windwp/nvim-autopairs'				"Auto pairs
	Plug 'nvim-lualine/lualine.nvim'				"Status line 
	Plug 'uZer/Pywal16.nvim'				"Pywal for color scheme
	
	"Dev stuff
	Plug 'tpope/vim-fugitive'				"Git integration
	Plug 'numToStr/FTerm.nvim'				"Floating terminal
	Plug 'wolandark/vim-live-server', 			"Runs server
	"LSP
	Plug 'neovim/nvim-lspconfig'				"Defines language server config
	Plug 'williamboman/mason.nvim'				"Manages/installs LSP executables
	Plug 'williamboman/mason-lspconfig.nvim'		"Mason nvim-lspconfig bridge
	Plug 'hrsh7th/cmp-nvim-lsp'				"LSP nvim-cmp brige for autocomplete suggestions
	Plug 'hrsh7th/nvim-cmp'					"Auto complete

	"Dependencies, not sure
	Plug 'MunifTanjim/nui.nvim'
	Plug 'nvim-lua/plenary.nvim'

call plug#end()

set notermguicolors
colorscheme default

" .lua
lua << EOF
require ( "neo-tree" ).setup({
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
			visible = true,
		},
	},
})
EOF

