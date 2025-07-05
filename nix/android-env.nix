let
  pkgs = import <nixpkgs> {};
in
pkgs.buildFHSEnv {
  name = "android-env";
  targetPkgs = pkgs: with pkgs; [
    flutter
    android-studio
    jdk17
    zlib
    gnome-keyring
    libsecret
    pulseaudio
    libpng
    nss
    nspr
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXtst
    xorg.libXi
    xorg.libxcb
    xorg.libXrandr
    glib
  ];
  runScript = "bash";
}
