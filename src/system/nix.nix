{
  config,
  pkgs,
  ...
}: {
  config = {
    nixpkgs.config = {
      allowBroken = true;
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
    nix = {
      # package = pkgs.nix;
      settings = {
        auto-optimise-store = true;
        show-trace = true;
        substituters = [
          "https://cache.nixos.org"
          "https://cache.ngi0.nixos.org"
          "https://nix-community.cachix.org"
          "https://nixfmt.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nixfmt.cachix.org-1:uyEQg16IhCFeDpFV07aL+Dbmh18XHVUqpkk/35WAgJI="
        ];
      };
    };
  };
}
