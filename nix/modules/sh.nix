{ config, pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "v1.2.0";
          sha256 = "sha256-q26XVS/LcyZPRqDNwKKA9exgBByE0muyuNb0Bbar2lY=";
        };
      }
    ];
    initExtra = ''
      # Make completion (including directory completion) case-insensitive
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      # Disable sort for git-checkout completion
      zstyle ':completion:*:git-checkout:*' sort false
      # Set description format to enable group support
      zstyle ':completion:*:descriptions' format '[%d]'
      # Disable default completion menu for fzf-tab to capture unambiguous prefix
      zstyle ':completion:*' menu no
      # To make fzf-tab follow FZF_DEFAULT_OPTS (optional)
      zstyle ':fzf-tab:*' use-fzf-default-opts yes
      # Switch group keys
      zstyle ':fzf-tab:*' switch-group '<' '>'

      # oh-my-posh init
      eval "$(oh-my-posh init zsh --config /home/p4p1/.config/ohmyposh/config.toml)"

      # Change keymap for autosuggestion
      bindkey '^E' autosuggest-accept

      # Custom function to create a directory and cd into it
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }
    '';
    shellAliases = {
      ns = "nix-shell";
      nrs = "sudo nixos-rebuild switch --flake ~/Documents/Projects/private/dotfiles/nix";
      hrs = "home-manager switch --flake ~/Documents/Projects/private/dotfiles/nix";
      la = "ls -la";
      lt = "tree -I '.git|vendor|node_modules'";
      lr = "lazydocker";
      lg = "lazygit";
      # NOTE: Docker compose aliases
      dcb = "docker compose build";
      dcps = "docker compose ps";
      dcrestart = "docker compose restart";
      dcrm = "docker compose rm";
      dcup = "docker compose up";
      dcupb = "docker compose up --build";
      dcupd = "docker compose up -d";
      dcupdb = "docker compose up -d --build";
      dcdn = "docker compose down";
      dcl = "docker compose logs";
      dclf = "docker compose logs -f";
      dclF = "docker compose logs -f --tail0";
    };
  };
}
