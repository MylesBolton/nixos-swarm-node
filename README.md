# NixOS Docker Swarm Node Configuration

## WIP

Personnal NixOS configuration for a docker swarm node

### Configures:

- Users
- GlusterFS
- Docker
- Auto-upgrades

### Steps:

1.  Create a CA certificate/key pair for your GlusterFS cluster, place the certificate as `./certs/glusterfs.ca` in each node.
    - oneliner for the cert
    ```
    mkdir -p ./certs && openssl req -new -x509 -days 3650 -keyout ./certs/glusterfs-ca.key -out ./certs/glusterfs.ca -nodes -subj "/C=UK/ST=State/L=City/O=Organization/CN=GlusterFS-CA"
    ```
2.  Use the CA to create certficates for each node, and add them as `./certs/glusterfs.pem` and `./certs/glusterfs.key` in the corresponding nodes.
    - oneliner for the pem and key
    ```
    openssl req -new -nodes -keyout ./certs/glusterfs.key -out ./certs/glusterfs.csr -subj "/C=UK/ST=State/L=City/O=Organization/CN=GlusterFS" && \
    openssl x509 -req -in ./certs/glusterfs.csr -CA ./certs/glusterfs.ca -CAkey ./certs/glusterfs-ca.key -CAcreateserial -out ./certs/glusterfs.pem -days 3650 && \
    rm ./certs/glusterfs.csr

        ```

3.  Edit the `node-config.nix` files with your values.
4.  Apply the nix configuration
5.  Setup the GlusterFS pools and volumes (see https://docs.gluster.org/en/latest/)
6.  Setup Docker Swarm
