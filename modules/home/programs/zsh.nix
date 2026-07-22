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
    initContent = lib.mkAfter ''
      # Source local zshrc file if it exists
      FILE=~/.zshrc.local && test -f $FILE && source $FILE
    '';

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
      '';
    };
  };
}