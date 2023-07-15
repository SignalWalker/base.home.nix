{
  description = "Home manager configuration - base";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homelib = {
      url = "github:signalwalker/nix.home.lib";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.alejandra.follows = "alejandra";
      inputs.home-manager.follows = "home-manager";
    };
    # shell
    fishFzf = {
      url = "github:PatrickF1/fzf.fish";
      flake = false;
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }:
    with builtins; let
      std = nixpkgs.lib;
    in {
      formatter = std.mapAttrs (system: pkgs: pkgs.default) inputs.alejandra.packages;
      homeManagerModules.default = {...}: {
        imports = [./home-manager.nix];
        config = {
          home.stateVersion = "22.11";
          lib.signal = inputs.homelib.lib;
          signal.base.homeManagerSrc = inputs.home-manager;
          programs.fish.pluginSources = {
            fzf = inputs.fishFzf;
          };
        };
      };
    };
}
