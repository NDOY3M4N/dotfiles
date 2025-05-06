{ pkgs, lib, ... }:

{
  home.username = "p4p1";
  home.homeDirectory = "/home/p4p1";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  # ];

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
    '';
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/Documents/Projects/private/dotfiles/nix";
      hrs = "home-manager switch --flake ~/Documents/Projects/private/dotfiles/nix";
      la = "ls -la";
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
  programs.zed-editor = {
	  enable = true;
	  extensions = ["nix" "toml" "make"];

	  ## everything inside of these brackets are Zed options.
	  userSettings = {
	    assistant = {
	      enabled = true;
		version = "2";
		default_open_ai_model = null;
		### PROVIDER OPTIONS
		### zed.dev models { claude-3-5-sonnet-latest } requires github connected
		### anthropic models { claude-3-5-sonnet-latest claude-3-haiku-latest claude-3-opus-latest  } requires API_KEY
		### copilot_chat models { gpt-4o gpt-4 gpt-3.5-turbo o1-preview } requires github connected
		default_model = { 
		    provider = "zed.dev";
		    model = "claude-3-5-sonnet-latest";
		};

		inline_alternatives = [
		  {
		    provider = "copilot_chat";
		    model = "gpt-3.5-turbo";
		  }
		];
	      };

	      node = {
		path = lib.getExe pkgs.nodejs;
		npm_path = lib.getExe' pkgs.nodejs "npm";
	      };

	      hour_format = "hour24";
	      auto_update = false;
	      terminal = {
		alternate_scroll = "off";
		blinking = "off";
		copy_on_select = false;
		dock = "bottom";
		detect_venv = {
		  on = {
		    directories = [".env" "env" ".venv" "venv"];
		    activate_script = "default";
		  };
		};
		env = {
		  TERM = "kitty";
		};
		font_family = "JetBrains Mono";
		font_features = null;
		font_size = null;
		line_height = "comfortable";
		option_as_meta = false;
		button = false;
		shell = "system"; 
		# { program = "zsh"; };
		toolbar = {
		  title = true;
		};
		working_directory = "current_project_directory";
	      };

	      lsp = {
		# rust-analyzer = {
		#   binary = {
		#       # path = lib.getExe pkgs.rust-analyzer;
		#       path_lookup = true;
		#   };
		# };

		nix = { 
		  binary = { 
		    path_lookup = true; 
		  }; 
		};

		# elixir-ls = {
		#   binary = {
		#     path_lookup = true; 
		#   };
		#   settings = {
		#     dialyzerEnabled = true;
		#   };
		# };
	      };

	      vim_mode = true;
	      ## tell zed to use direnv and direnv can use a flake.nix enviroment.
	      load_direnv = "shell_hook";
	      # base_keymap = "VSCode";
	      theme = {
		mode = "system";
		light = "One Light";
		dark = "Catppuccin Mocha";
	      };
	      show_whitespaces = "all" ;
	      ui_font_size = 16;
	      buffer_font_size = 16;
	    };
	};


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

  home.file.".config/bat/config".text = ''
    --theme="Catppuccin Mocha"
    --style="numbers,changes,grid"
    --paging=auto
  '';

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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
