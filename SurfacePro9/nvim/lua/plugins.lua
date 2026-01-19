-- Plugin Loading

vim.cmd([[
  call plug#begin()

  " Utilities
  Plug 'nvim-neo-tree/neo-tree.nvim'                    "File tree
  Plug 'norcalli/nvim-colorizer.lua'                    "Displays hex code colors when typed
  Plug 'folke/which-key.nvim'                           "Shortcut reference
  Plug 'nvim-telescope/telescope.nvim'                  "Modern fuzzy finder
  Plug 'nvim-treesitter/nvim-treesitter'		"Better syntax highlighting
  Plug 'MeanderingProgrammer/render-markdown.nvim'      "Renders md files in buffer

  " Fonts, Icons, Status Lines, & ColorScheme
  Plug 'nvim-tree/nvim-web-devicons'                    "Dev icons
  Plug 'onsails/lspkind.nvim'				"Auto complete UI
  Plug 'windwp/nvim-autopairs'                          "Auto pairs
  Plug 'nvim-lualine/lualine.nvim'                      "Status line
  Plug 'folke/tokyonight.nvim'                  	"Colorscheme

  " Dev stuff
  Plug 'tpope/vim-fugitive'                             "Git integration
  Plug 'numToStr/FTerm.nvim'                            "Floating terminal
  Plug 'wolandark/vim-live-server',                     "Runs server

  " LSP
  Plug 'neovim/nvim-lspconfig'                          "Defines language server config
  Plug 'williamboman/mason.nvim'                        "Manages/installs LSP executables
  Plug 'williamboman/mason-lspconfig.nvim'              "Mason nvim-lspconfig bridge
  Plug 'hrsh7th/cmp-nvim-lsp'                           "LSP nvim-cmp brige for autocomplete sugg>
  Plug 'hrsh7th/nvim-cmp'                               "Auto complete
  Plug 'hrsh7th/cmp-buffer'      			" Buffer Source
  Plug 'hrsh7th/cmp-path'        			" Path Source

  " Dependencies, not sure
  Plug 'MunifTanjim/nui.nvim'
  Plug 'nvim-lua/plenary.nvim' 

  call plug#end()
]])
-- ================================
-- 	Plugin Configurations
-- ===============================
require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
		 	hide_gitignored = false,
			visible = true,
		},
	},
})

require("mason").setup({
    ensure_installed = {
        "ts_ls",   
        "pyright",    
        "lua_ls",     
        "html",       
        "cssls",      
    },
})

require("mason-lspconfig").setup({
    automatic_installation = true, 
    ensure_installed = {
        "ts_ls",
        "pyright",
        "lua_ls",
	"html",
	"cssls",
    },
})

require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        disable = {},
    },
    ensure_installed = {
	"c",
	 "lua",
	 "vim",
	 "python", 
	"javascript", 
	"typescript", 
	"tsx", 
	"html", 
	"css"
	},
    auto_install = true,
})

-- nvim-cmp config
local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
    -- Sources for suggestions
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },  -- MUST be first to get LSP suggestions (errors, functions, etc.)
        { name = 'buffer' },    -- Suggestions from the text in the current file
        { name = 'path' },      -- File and directory paths
    }),

    -- Autocomplete menu looks
    formatting = {
        format = lspkind.cmp_format({
            with_background = true,
            menu = {
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                path = "[Path]",
            },
        }),
    },

    -- Keymaps for interacting with the completion menu
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),  
        ['<S-Tab>'] = cmp.mapping.select_prev_item(), 

        -- To show the menu if it's closed
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})

-- not working, fix
require("tokyonight").setup({
	style="storm",
	transparent = true,
	terminal_colors = true,
})
