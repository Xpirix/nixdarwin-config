{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.home-manager
      pkgs.vscode
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/src/github.com/Xpirix/nixdarwin-config/darwin";

  # Auto upgrade nix package and the daemon service.
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # programs = {
  #   zsh.enable = true;  # default shell on catalina
  # };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  fonts.packages = with pkgs; [
    atkinson-hyperlegible
    jetbrains-mono
    cascadia-code
    nerd-fonts.caskaydia-cove
  ];

  services = {
    nix-daemon.enable = true;
  };

  homebrew = {
    enable = true;

    casks = [
      "iterm2"
      "orbstack"
    ];
  };
  

}
