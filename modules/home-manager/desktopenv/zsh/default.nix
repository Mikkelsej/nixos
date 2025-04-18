{ config, pkgs, ... }:


let
  zshAliases = import ./aliases.nix { inherit config pkgs; };
  zshInitExtra = import ./init.nix { inherit config pkgs; };
in

{
  # Enable Zsh shell
  programs.zsh = {
    enable = true;
		enableCompletion = true;
		syntaxHighlighting.enable = true;
		autosuggestion.enable = true;

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];

    # Aliases
    shellAliases = zshAliases.shellAliases;
    initExtra = zshInitExtra.initExtra;
  };

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  # Enable Home Manager to manage the user's home environment
  programs.home-manager.enable = true;
}
