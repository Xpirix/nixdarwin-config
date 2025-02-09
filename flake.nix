{
  description = "Xpirix's Nix System Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    deepseek.url = "github:lucernae/nix-config?dir=process-compose/llm/deepseek-r1";
  };
  outputs = {
    nixpkgs,
    darwin,
    home-manager,
    ...
  } @ inputs: let
    system = "aarch64-darwin";
    pkgs = import nixpkgs { inherit system; };
    darwinSystem = {user, arch ? "aarch64-darwin"}:
      darwin.lib.darwinSystem {
        system = arch;
        modules = [
          ./darwin/darwin.nix
          home-manager.darwinModules.home-manager
          {
            _module.args = { inherit inputs; };
            home-manager = {
              users.${user} = import ./home-manager {
                inherit inputs pkgs;
              };
            };
            users.users.${user} = {
              home = "/Users/${user}";
            };
            nix.settings.trusted-users = [ user ];
            nixpkgs.config.allowUnfree = true;

          }
        ];
      };
  in
  {
    darwinConfigurations = {
      "MacBook-M1-Pro" = darwinSystem {
        user = "xpirix";
        arch = "aarch64-darwin";
      };
    };
  };
}
