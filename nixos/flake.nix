{
  description = "My NixOS Configurations";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    plasma-manager,
    flake-utils,
    ... }@inputs:
  let
    hostConfigurations = {
      "desktop"     = { system = "x86_64-linux"; };
      "mac-virtual" = { system = "aarch64-linux"; };
    };

    commonModule = inputs: {config, pkgs, ...}: {
      imports = [
	./common/configuration.nix
      ];
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users."bex" = {
        imports = [
          (import ./common/home.nix {
            inherit pkgs;
            plasma-manager = inputs.plasma-manager;
          })
        ];
        home.stateVersion = "25.05";
      };
    };

    mkHost = hostName: {system}:
      nixpkgs.lib.nixosSystem {
	inherit system;
        specialArgs = { inherit inputs; };
	modules = [
	  inputs.home-manager.nixosModules.home-manager
	  (commonModule inputs)
	  (./hosts + "/${hostName}/hardware-configuration.nix")
	  (./hosts + "/${hostName}/default.nix")
	];
      };
  in {
    nixosConfigurations = nixpkgs.lib.mapAttrs mkHost hostConfigurations;
  };
}
