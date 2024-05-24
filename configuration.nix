{ config, pkgs, ... }:

{

  imports = [
    # Add hardware scan configuration.
    ./hardware-configuration.nix
    # Add environment settings.
    ./environment.nix
    # Add packages.
    ./packages.nix
    # Add glusetrfs
    ./glusterfs.nix
    # Add mounts
    ./mounts.nix
    # Add users
    ./users.nix
  ];


  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  services = {
    journald = {
      extraConfig = ''
        SystemMaxUse=50M
      '';
    };
    openssh = {
        enable = true;
        settings.PasswordAuthentication = false;
    };
  };

  system = {
    autoUpgrade = {
      channel= "https://nixos.org/channels/nixos-23.11";
      enable = true;
      allowReboot = true;
    };
    stateVersion = "23.11";
  };

  time.timeZone = "Europe/London";

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };
}