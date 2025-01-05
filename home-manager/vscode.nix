{ pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    # This doesn't append the extensions to the list of installed extensions
    # extensions = with pkgs.vscode-extensions; [
    #   mskelton.one-dark-theme
    #   pkief.material-icon-theme
    #   pkief.material-product-icons
    #   bbenoist.nix
    #   ms-python.vscode-pylance
    #   ms-python.python
    #   github.copilot
    #   github.copilot-chat
    #   eamodio.gitlens
    # ];
  };

}
