# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Matamoros";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable Hyprland
  programs.hyprland.enable = true;

  # Screen sharing/compatability
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.oscar = {
    isNormalUser = true;
    description = "oscar";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:$ nix search wget
  environment.systemPackages = with pkgs; [
	kitty
	waybar
	mako
	swww
	wofi
	obsidian
	hyprpaper
	pywal16
	git
	gh
	vscode-fhs
	gcc
	gnumake
	unzip
	wget
	ripgrep
	fd
	lua-language-server
    pyright
    nodePackages.typescript-language-server
    vscode-langservers-extracted

	(neovim.override {
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [ 
            # UI & Essentials
            adwaita-nvim neo-tree-nvim nvim-colorizer-lua which-key-nvim
            telescope-nvim nvim-treesitter.withAllGrammars render-markdown-nvim
            nvim-web-devicons lspkind-nvim nvim-autopairs lualine-nvim tokyonight-nvim
            
            # Dev & Git
            vim-fugitive fterm-nvim
            
            # LSP & Autocomplete
            nvim-lspconfig cmp-nvim-lsp nvim-cmp cmp-buffer cmp-path
            nui-nvim plenary-nvim
          ];
        };
        customRC = ''
          lua << EOF
          -- Basic UI
          vim.opt.termguicolors = true
          vim.opt.number = true
          vim.opt.relativenumber = true

          -- Neo-tree
          require("neo-tree").setup({
            filesystem = { filtered_items = { hide_dotfiles = false } }
          })

          -- LSP Config (Directly calling binaries installed via Nix)
          local lspconfig = require('lspconfig')
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          local servers = { 'ts_ls', 'pyright', 'lua_ls', 'html', 'cssls' }
          for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup { capabilities = capabilities }
          end

          -- Autocomplete (CMP)
          local cmp = require('cmp')
          cmp.setup({
            sources = {
              { name = 'nvim_lsp' },
              { name = 'buffer' },
              { name = 'path' },
            },
            mapping = cmp.mapping.preset.insert({
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
              ['<Tab>'] = cmp.mapping.select_next_item(),
            }),
          })
          EOF
		  '';
      	};
      })
    ];
	
	environment.etc."xdg/kitty/kitty.conf".text = ''
		background                #000000
		foreground                #deddda

		selection_background      #1c1c1c
		selection_foreground      #c0bfbc

		url_color                 #1a5fb4

		wayland_titlebar_color    system
		macos_titlebar_color      system

		cursor                    #deddda
		cursor_text_color         #000000

		active_border_color       #1e1e1e
		inactive_border_color     #282828
		bell_border_color         #ed333b
		visual_bell_color         none

		active_tab_background     #101010
		active_tab_foreground     #fcfcfc
		inactive_tab_background   #1c1c1c
		inactive_tab_foreground   #b0afac
		tab_bar_background        none
		tab_bar_margin_color      none

		color0                    #000000
		color1                    #ed333b
		color2                    #57e389
		color3                    #ff7800
		color4                    #62a0ea
		color5                    #9141ac
		color6                    #5bc8af
		color7                    #deddda

		color8                    #9a9996
		color9                    #f66151
		color10                   #8ff0a4
		color11                   #ffa348
		color12                   #99c1f1
		color13                   #dc8add
		color14                   #93ddc2
		color15                   #f6f5f4

		## My additions
		background_opacity 0.4
	'';	

 

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
