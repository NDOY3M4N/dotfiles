# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Dakar";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the Wayland windowing system.
  services.xserver = {
    enable = true;
    # Enable the GNOME Desktop Environment and use Wayland
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # displayManager.gdm.waylandOnly = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    graphics.enable = true;
    # nvidia.modesetting.enable = true;
  };

  # NOTE: mysql
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    # package = pkgs.mysql;
    initialScript = "/etc/nixos/mysql-init.sql";
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-wlr
  ];

  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
  };

  # Needed by nautilus/pcmanfm
  services.gvfs.enable = true;

  services.usbmuxd.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # NOTE: using bluetooth headset buttons to control media player
  # systemd.user.services.mpris-proxy = {
  #   description = "Mpris proxy";
  #   after = [ "network.target" "sound.target" ];
  #   wantedBy = [ "default.target" ];
  #   serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.p4p1 = {
    isNormalUser = true;
    description = "Abdoulaye NDOYE";
    extraGroups = [ "networkmanager" "wheel" ];
    # packages = with pkgs; [
    # #  thunderbird
    # ];
  };

  # virtualisation.docker.enable = true;
  # virtualisation.docker.storageDriver = "btrfs";
  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
  # };

  # Install firefox.
  programs.firefox.enable = true;

  # Install Hyprland
  programs.hyprland.enable = true;

  # Enable hyprlock
  programs.hyprlock.enable = true;

  # To allow hyprlock to authenticate
  security.pam.services.hyprlock = {};

  # Enable zsh and set as default shell for all users
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    iw
    libnotify
    curl
    kitty
    wget
    unzip
    wlogout
    nautilus
    pcmanfm
    pavucontrol
    brightnessctl
    lua5_1
    lua51Packages.luarocks-nix  # Luarocks for Lua 5.1
    git
    gnome-network-displays

    # NOTE: for device connection
    libimobiledevice
    ifuse
    usbmuxd
    gvfs

    (python3.withPackages (ps: with ps; [
      dbus-next
      psutil
    ]))
  ];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      ibm-plex
      jetbrains-mono
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    # enableZshIntegration = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 7236 7250 ];
  networking.firewall.allowedUDPPorts = [ 7236 5333 ];
  networking.firewall.trustedInterfaces = [ "p2p-wl+" ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
