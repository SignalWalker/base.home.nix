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
        dependencies = signal.dependency.default.fromInputs {
          inherit inputs;
          filter = ["alejandra"];
        };
        outputs = dependencies: {
          homeManagerModules.default = {...}: {
            imports = [./home-manager.nix];
            config = {
              home.stateVersion = "22.11";
              lib.signal = dependencies.homelib.input.lib;
              signal.base.homeManagerSrc = dependencies.home-manager.input;
            };
          };
        };
      };
      homeConfigurations = home.genConfigurations self;
      packages = home.genActivationPackages self.homeConfigurations;
      apps = home.genActivationApps self.homeConfigurations;
    };
}
