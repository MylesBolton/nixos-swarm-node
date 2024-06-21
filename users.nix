{ config, ... }:

with (import ./node-config.nix);
{
  users = {
    users."${hostname}" = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = ["wheel"];
        password = hostname;
        openssh.authorizedKeys.keyFiles = [
            (builtins.fetchurl "https://github.com/MylesBolton.keys")
        ];
    };
  };
}