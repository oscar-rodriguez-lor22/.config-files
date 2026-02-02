# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  programs.waybar.enable = false;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set general system info
  time.timeZone = "America/Matamoros";
  i18n.defaultLocale = "en_US.UTF-8";

  # Windowing/Desktop Environment
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  programs.hyprland.enable = true;

  # Display Manager
  services.displayManager.ly.enable = true;
  services.displayManager.ly.settings = {
  animation = "matrix"; # or "fire"
  bigclock = true;
};

  # Screen sharing/compatability
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Pipewire Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Users
  users.users.oscar = {
    isNormalUser = true;
    description = "oscar";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # App Permissions and Installs
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.packages = with pkgs; [
	nerd-fonts.bigblue-terminal
  ];
 fonts.fontconfig.defaultFonts.monospace = ["Terminess Nerd Font"];
  # List packages installed in system profile.
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
	btop
	yazi
	lazygit
	neofetch
	bemenu
  ];

  # Nvim Config
  programs.neovim = {
	enable = true;
	defaultEditor = true;
	configure = {
		packages.myVimPackage = with pkgs.vimPlugins; {
			start = [
				neo-tree-nvim 
				nvim-colorizer-lua 
				which-key-nvim
				adwaita-nvim 
				telescope-nvim 
				nvim-treesitter.withAllGrammars
				render-markdown-nvim 
				nvim-web-devicons 
				lspkind-nvim
				nvim-autopairs 
				lualine-nvim 
				vim-fugitive
				nvim-lspconfig
				cmp-nvim-lsp 
				nvim-cmp
				cmp-buffer 
				cmp-path 
				nui-nvim
				plenary-nvim	
			];
			opt = [];
		};
	customRC = ''
		set termguicolors
		set relativenumber
	'';
	};
  };

  # Kitty Config
  environment.etc."xdg/kitty/kitty.conf".source = pkgs.writeText "kitty.conf" ''
  	font_family 			BigBlueTerm Nerd Font
  	
	foreground #c9d1d9
	background #0d1117
	selection_foreground #0d1117
	selection_background #58a6ff
	cursor #58a6ff
	tab_bar_background #010409
	active_tab_foreground #c9d1d9
	active_tab_background #0d1117
	inactive_tab_foreground #8b949e
	inactive_tab_background #010409
	color0 #484f58
	color8 #6e7681
	color1 #ec8e2c
	color9 #fdac54
	color2 #58a6ff
	color10 #79c0ff
	color3 #d29922
	color11 #e3b341
	color4 #58a6ff
	color12 #79c0ff
	color5 #bc8cff
	color13 #d2a8ff
	color6 #39c5cf
	color14 #56d4dd
	color7 #b1bac4
	color15 #ffffff
	background_opacity		0.8
'';

  # Nvim Config 

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
