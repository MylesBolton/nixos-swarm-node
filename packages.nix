{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        git
        neovim
        wget
        curl
        k3s
        gnupg
        nano
        tailscale
    ];
}