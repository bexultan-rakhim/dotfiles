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

  outputs = {self, nixpkgs, home-manager, plasma-manager, ...}@inputs: {
    
    nixosConfigurations = {
      "mac-virtual" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
	specialArgs = {inherit inputs;};
        modules = [
	  ./hosts/mac-virtual/hardware-configuration.nix
	  ./hosts/mac-virtual/default.nix
	  ./common/configuration.nix
	  home-manager.nixosModules.home-manager
	  ({ pkgs, ...}: {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users."bex" = {
	      imports = [
		(import ./common/home.nix {
		  inherit pkgs;
	          inherit plasma-manager;
		})
	      ];
	      home.stateVersion = "25.05";
	    };
	  })
	];
      };

      "desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	  ./hosts/desktop/hardware-configuration.nix
	  ./hosts/desktop/default.nix
	  ./common/configuration.nix
	  home-manager.nixosModules.home-manager
	  ({ pkgs, ...}: {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users."bex" = {
	      imports = [
		(import ./common/home.nix {
		  inherit pkgs;
	          inherit plasma-manager;
		})
	      ];
	      home.stateVersion = "25.05";
	    };
	  })
	];
      };
    };
  };
}
