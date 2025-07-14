{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.home-manager
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

  security.pam.services.sudo_local.touchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;  # default shell on catalina
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  system.primaryUser = "xpirix";

  fonts.packages = with pkgs; [
    atkinson-hyperlegible
    jetbrains-mono
    cascadia-code
    nerd-fonts.caskaydia-cove
  ];

  homebrew = {
    enable = true;

    casks = [
      "iterm2"
      "orbstack"
      "firefox"
      "google-chrome"
      "pgadmin4"
      "tor-browser"
      "aldente"
      "chatgpt"
      "vlc"
      "flameshot"
      "obs"
      "element"
      "warp"
      "grammarly-desktop"
      "gimp"
      "libreoffice"
      "licecap"
      "tomatobar"
      "postman"
      "maccy"
    ];

    brews = [
      "node"
      # For commit signing
      "gnupg"
      "pinentry-mac"
    ];

    # Apple Store Apps defined with ID
    masApps = {
      "Orbot" = 1609461599;
      "Tailscale" = 1475387142;
      "WhatsApp" = 310633997;
    };
  };


}
