{ config, pkgs, ... }:

{
  imports = [
    ./modules/sh.nix
    ./modules/zed.nix
  ];

  home.username = "p4p1";
  home.homeDirectory = "/home/p4p1";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    # settings = ".config/ohmyposh/config.toml";
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  # programs.kitty.enable = true;

  programs.git = {
    enable = true;
    userName  = "NDOY3M4N";
    userEmail = "pa.ndoye@outlook.fr";
    includes = [
      {
        condition = "gitdir:~/Documents/Projects/simen/";
        path = "~/Documents/Projects/simen/.gitconfig";
      }
    ];
  };

  programs.zoxide.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    fileWidgetOptions = [
    	"--preview 'bat -n --color=always {}'"
    	"--walker-skip .git,node_modules,vendor"
    ];
    changeDirWidgetOptions = [
    	"--walker-skip .git,node_modules,vendor"
      "--preview 'tree -C {}'"
    ];
    colors = {
      "bg+"         = "#313244";
      "bg"          = "#1e1e2e";
      "spinner"     = "#f5e0dc";
      "hl"          = "#f38ba8";
      "fg"          = "#cdd6f4";
      "header"      = "#f38ba8";
      "info"        = "#cba6f7";
      "pointer"     = "#f5e0dc";
      "marker"      = "#b4befe";
      "fg+"         = "#cdd6f4";
      "prompt"      = "#cba6f7";
      "hl+"         = "#f38ba8";
      "selected-bg" = "#45475a";
      "border"      = "#313244";
      "label"       = "#cdd6f4";
    };
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  services.swaync.enable = true;

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home.packages = with pkgs; [
    # NOTE: must have CLI tools
    git
    gh
    glab
    bat
    neofetch
    stow
    zoxide
    pass
    btop
    ripgrep
    fd
    httpie
    httpie-desktop
    jq
    lazydocker
    lazygit
    tree

    gcr
    wl-clipboard
    playerctl
    rofi-wayland
    alsa-utils
    pamixer
    kanata
    # picom
    brave
    cava
    networkmanagerapplet
    ranger
    nodejs
    gnumake
    gcc
    go
    zathura
    sqlite
    obsidian
    mpv
    beekeeper-studio
    telegram-desktop
    ffmpeg
    # NOTE: the display wallpaper stuffs
    ags
    swww
    wallust
    # NOTE: for screenshots
    grim
    swappy
    slurp
    # NOTE: VT100
    cmus
    cargo
    goose
    sqlc
    air
    kitty
    ghostty
    gnome-network-displays
    rqbit
    highlight
    glow
    slides

    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
