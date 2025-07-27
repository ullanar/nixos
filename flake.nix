{
  description = "Ullanar's NixOS configuration";
  
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Rust overlay for better Rust toolchain management
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Sops-nix for secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, home-manager, rust-overlay, sops-nix, ... }@inputs: {
    nixosConfigurations = {
      # Desktop configuration
      nixarchy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nixarchy/default.nix
          # Add rust-overlay
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
          })
          # Add sops-nix system module
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lev = import ./home_manager/default.nix;
            # Pass inputs to home-manager (including sops-nix)
            home-manager.extraSpecialArgs = { inherit inputs; };
            # Add backup file extension
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
      
      # Laptop configuration
      nixtop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nixtop/default.nix
          # Add rust-overlay
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
          })
          # Add sops-nix system module
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lev = import ./home_manager/default.nix;
            # Pass inputs to home-manager (including sops-nix)
            home-manager.extraSpecialArgs = { inherit inputs; };
            # Add backup file extension
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
  };
}
