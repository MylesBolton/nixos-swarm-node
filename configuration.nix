{ config, pkgs, ... }:

{

  imports = [
    #Add hardware config
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/raspberry-pi/4"
    # Add environment settings.
    ./environment.nix
    # Add packages.
    ./packages.nix
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

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  services = {
    openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
    };
    tailscale.enable = true;
    k3s.enable = true;
  };

  system = {
    autoUpgrade = {
      channel= "https://nixos.org/channels/nixos-23.11";
      enable = true;
      allowReboot = true;
    };
    stateVersion = "23.11";
  };

  hardware.enableRedistributableFirmware = true;
  time.timeZone = "Europe/London";
}