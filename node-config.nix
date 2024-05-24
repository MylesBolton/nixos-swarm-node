{
    updateDay = "Sat";
    hostname = "example-node";
    customNameServers = ["10.0.0.0"];
    networkInterface = "end0";
    ipAddress = "10.0.0.0";
    ipPrefixLength = 24;
    gateway = "10.0.0.0";
    usernames = ["MylesBolton" "PhionSecurityAdmin"];
    glusterVolumes = {
        configs = [ "./test-dir" ];
    };
}