{
  description = "My side chick flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager/master";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        side-chick = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };

      # homeConfigurations = {
      #   p4p1 = home-manager.lib.homeManagerConfiguration {
      #     inherit pkgs;
      #     modules = [ ./home.nix ];
      #   };
      # };
    };
}
