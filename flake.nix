{
  description = "Home manager configuration - base";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    alejandra = {
      url = github:kamadorueda/alejandra;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homelib = {
      url = github:signalwalker/nix.home.lib;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.alejandra.follows = "alejandra";
      inputs.home-manager.follows = "home-manager";
    };
    # keyboard
    xremap = {
      url = github:signalwalker/xremap;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.alejandra.follows = "alejandra";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    homelib,
    ...
  }:
    with builtins; let
      std = nixpkgs.lib;
      hlib = homelib.lib;
      home = hlib.home;
      signal = hlib.signal;
    in {
      formatter = std.mapAttrs (system: pkgs: pkgs.default) inputs.alejandra.packages;
      signalModules.default = {
        name = "home.base.default";
        dependencies = signal.flake.set.toDependencies {
          flakes = inputs;
          filter = ["alejandra"];
        };
        outputs = dependencies: {
          homeManagerModules = {...}: {
            imports = [./home-manager.nix];
            config = {
              home.stateVersion = "22.11";
              lib.signal = dependencies.homelib.lib;
              signal.base.homeManagerSrc = dependencies.home-manager;
            };
          };
        };
      };
      homeConfigurations = home.configuration.fromFlake {
        flake = self;
        flakeName = "home.base";
      };
      packages = home.package.fromHomeConfigurations self.homeConfigurations;
      apps = home.app.fromHomeConfigurations self.homeConfigurations;
    };
}
