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
  # NOTE: for kanata
  boot.kernelModules = [ "uinput" ];

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

  programs.nix-ld.enable = true;

  # Enable the Wayland windowing system.
  services = {
    # Enable the GNOME Desktop Environment and use Wayland
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    TERMINAL = "kitty";

    # Node-API (dynamic library) for Prisma Client
    PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
    # CLI engines (schema/migration/introspection)
    PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
    PRISMA_INTROSPECTION_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/introspection-engine";
    PRISMA_MIGRATION_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/migration-engine-cli";
  };

  hardware = {
    graphics.enable = true;
    uinput.enable = true;
    # nvidia.modesetting.enable = true;
  };

  # NOTE: kanata

  # services.gnome-keyring.enable = true;

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
            caps a s d f j k l ;
          )

          (defalias
            caps (tap-hold 250 250 esc lctl)

            a (tap-hold 250 250 a lmet)
            s (tap-hold 250 250 s lalt)
            d (tap-hold 250 250 d lsft)
            f (tap-hold 250 250 f lctl)
            j (tap-hold 250 250 j rctl)
            k (tap-hold 250 250 k rsft)
            l (tap-hold 250 250 l ralt)
            ; (tap-hold 250 250 ; rmet)
          )

          (deflayer base
            @caps @a @s @d @f @j @k @l @;
          )
        '';
      };
    };
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

  users.groups.uinput = { };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.p4p1 = {
    isNormalUser = true;
    description = "Abdoulaye NDOYE";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "uinput"
    ];
  };

  virtualisation.docker = {
    enable = true;
    # Use the rootless mode - run Docker daemon as non-root user
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

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

  nixpkgs.config.android_sdk.accept_license = true;
  programs.adb.enable = true;

  # environment.shellInit = ''
  #   export PATH=$PATH:$HOME/Android/Sdk/platform-tools
  #   export PATH=$PATH:$HOME/Android/Sdk/cmdline-tools/latest/bin
  #   export PATH=$PATH:$HOME/Android/Sdk/emulator/emulator
  # '';

  environment.variables = {
    # ANDROID_AVD_HOME = "$HOME/.android/avd";
    # ANDROID_HOME = "$HOME/Android/Sdk";
    # ANDROID_SDK_ROOT = "$ANDROID_HOME";
    # PKG_CONFIG_PATH = "${pkgs.libsecret.dev}/lib/pkgconfig";
    JAVA_HOME = "${pkgs.jdk21_headless}/lib/openjdk";
    JDTLS_JVM_ARGS = "-javaagent:$HOME/.local/share/java/lombok.jar";
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    gnome-keyring

    prisma
    prisma-engines

    # flutter
    # android-studio
    # jdk21
    # firebase-tools
    # libsecret


    # openjdk17
    jdk21_headless
    # (maven.override { jdk = jdk21_headless; })
    # (spring-boot-cli.override { jdk = jdk21_headless; })
    maven
    spring-boot-cli

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
    kanata
    upower

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
      nerd-fonts.symbols-only
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
