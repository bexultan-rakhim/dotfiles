{
  description = "My NixOS Configurations";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = {self, nixpkgs, ...}: {
    
    nixosConfigurations = {
      "mac-virtual" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
	  ./hosts/mac-virtual/hardware-configuration.nix
	  ./hosts/mac-virtual/default.nix
	  ./common/configuration.nix
	];
      };

      "desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	  ./hosts/desktop/hardware-configuration.nix
	  ./hosts/desktop/default.nix
	  ./common/configuration.nix
	];
      };
    };
  };
}
