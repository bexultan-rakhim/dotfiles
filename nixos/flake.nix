{
  description = "My NixOS Configurations";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    hostConfigurations = {
      "desktop"     = { system = "x86_64-linux"; };
      "mac-virtual" = { system = "aarch64-linux"; };
    };

    mkHost = hostName: {system}:
      nixpkgs.lib.nixosSystem {
	inherit system;
        specialArgs = { inherit inputs; };
	modules = [
	  ./common/configuration.nix
	  (./hosts + "/${hostName}/hardware-configuration.nix")
	  (./hosts + "/${hostName}/default.nix")
	];
      };
  in {
    nixosConfigurations = nixpkgs.lib.mapAttrs mkHost hostConfigurations;
  };
}
