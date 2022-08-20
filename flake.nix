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
      nixpkgsFor = hlib.genNixpkgsFor {
        inherit nixpkgs;
        overlays = system: self.lib.selectOverlays ["default" system];
      };
    in {
      formatter = std.mapAttrs (system: pkgs: pkgs.default) inputs.alejandra.packages;
      lib.overlays = hlib.aggregateOverlays (attrValues (removeAttrs inputs ["nixpkgs" "alejandra"]));
      lib.selectOverlays = hlib.selectOverlays' self;
      homeManagerModules.default = let
        stateVersion = "22.11";
      in
        {lib, ...}: {
          options = with lib; {
            signal.base.flakeInputs = mkOption {
              type = types.attrsOf types.anything;
              default = inputs;
            };
            # signal.base.enable = (mkEnableOption "base configuration") // {default = true;};
            system.isNixOS = (mkEnableOption "allows configuration specific to NixOS systems") // {default = true;};
          };
          imports = [
            ./home-manager.nix
          ];
          config = {
            lib.signal = hlib;
            home.stateVersion = stateVersion;
          };
        };
      homeConfigurations =
        mapAttrs (system: pkgs: {
          default = hlib.genHomeConfiguration {
            inherit pkgs;
            modules = [self.homeManagerModules.default];
          };
        })
        nixpkgsFor;
      packages = hlib.genHomeActivationPackages self.homeConfigurations;
      apps = hlib.genHomeActivationApps self.homeConfigurations;
    };
}
