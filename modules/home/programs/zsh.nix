{ config, lib, pkgs, ...}:

let
  zshCustomDirectory = "${config.home.homeDirectory}/.oh-my-zsh/custom";
in {
  home.file = {
    "${zshCustomDirectory}/themes/bullet-train.zsh-theme" = {
        source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/caiogondim/bullet-train.zsh/refs/heads/master/bullet-train.zsh-theme";
        hash = "sha256-R77AY/CPUI+19UbyV7o8Us5J+uQFfebzJWy5JnXzhNQ=";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    dotDir = lib.mkDefault "${config.xdg.configHome}/zsh";
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "doctl"
        "kubectl"
        "asdf"
      ];
      theme = "bullet-train";
      custom = zshCustomDirectory;
      extraConfig = ''
        BULLETTRAIN_PROMPT_ORDER=(
          time
          context
          dir
          git
        )

        BULLETTRAIN_CONTEXT_DEFAULT_USER=${config.home.username}

        export TELEPORT_LOGIN='Corvimae'
        export TELEPORT_PROXY='teleport.gamesdonequick.com:443'
        export TELEPORT_AUTH_SERVER='teleport.gamesdonequick.com:443'
        export TELEPORT_AUTH='github'
      '';
    };
  };
}