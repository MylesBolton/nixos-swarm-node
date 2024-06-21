{ config, ... }:

with (import ./node-config.nix);
{
    system.autoUpgrade.dates = "${updateDay} *-*-* 04:00:00";

    networking = {
        hostName = hostname;
        nameservers = name-servers ++ [
        "1.1.1.1"
        "1.0.0.1"
        ];
        interfaces = {
            "${networkInterface}" = {
                ipv4 = {
                    addresses = [
                        {
                        address = ip-address;
                        prefixLength = ip-prefix;
                        }
                    ];
                };
            };
        };
        defaultGateway = {
            address = gateway;
            interface = network-interface;
        };
        firewall{
            enable = true;
            allowedTCPPorts = tcp-ports;
            allowedUDPPorts = udp-ports;
        }
  };
}