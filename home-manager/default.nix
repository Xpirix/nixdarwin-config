{ inputs, pkgs, ... }:

{
  imports = [
    ./helix.nix
    ./starship.nix
    ./vscode.nix
    ./nvim
    ./deepseek.nix
  ];

  home = {
    stateVersion = "24.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      python313
      hugo
      inputs.deepseek.packages.${pkgs.system}.default
      devbox
      act
    ];

    sessionVariables = {
    };
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
      set fish_greeting "Hello world! 😂"
      set -gx PATH /run/current-system/sw/bin $PATH
      set -gx PATH /opt/homebrew/bin $PATH
      set -gx PATH /opt/local/bin $PATH
      alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
      set -gx PATH /Users/xpirix/.nix-profile/bin $PATH
      set -gx PATH /Users/xpirix/.local/bin $PATH
      '';
    };

    # direnv = {
    #   enable = true;
    #   nix-direnv.enable = true;
    # };

  };
}
