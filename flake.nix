{
  description = "NixOS configurations for my devices";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = builtins.currentSystem;
      pkgs = import nixpkgs { inherit system; };
      currentHostName = builtins.elemAt (builtins.split "\n" (builtins.readFile /etc/hostname)) 0;
      currentUsername = builtins.getEnv "SUDO_USER";
    in
    {
      nixosConfigurations."${currentHostName}" = nixpkgs.lib.nixosSystem {
        modules = [
          (import ./hosts/${currentHostName}/configuration.nix { inherit system nixpkgs; })
          home-manager.nixosModules.home-manager
          {
            home-manager.users."${currentUsername}" =
              import /home/${currentUsername}/.config/home-manager/users/${currentUsername}/home.nix
                { inherit system nixpkgs currentUsername; };
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
}
