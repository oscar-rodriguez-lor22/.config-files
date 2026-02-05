{ config, pkgs, ... }:

{
  programs.gh.enable = true;
  home.stateVersion = "24.11"; 

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      neo-tree-nvim
      nvim-colorizer-lua
      which-key-nvim
      github-nvim-theme
      lualine-nvim
      nvim-web-devicons
      render-markdown-nvim
      telescope-nvim
      plenary-nvim
      nui-nvim
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      lspkind-nvim
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      nvim-autopairs
      vim-fugitive
    ];

    extraConfig = ''
      set termguicolors
      set relativenumber
      colorscheme github_dark_colorblind
    '';

    extraLuaConfig = ''
      require('neo-tree').setup({
        tabs_layout = "start",
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_ignored = false,
          }
        }
      })
    ''; 
  }; 
}
       
