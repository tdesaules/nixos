{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];
  boot.initrd.availableKernelModules = [ "xhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  fileSystems."/" = { 
    device = "/dev/disk/by-uuid/e54f17c1-7b6c-4a8d-8fef-ce18685874dd";
    fsType = "btrfs";
    options = [
      "subvol=@"
    ];
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C761-992E";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };
  swapDevices = [ ];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  services.qemuGuest.enable = true;
}
