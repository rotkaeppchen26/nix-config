# Derrick's Nix Config

## Hosts

### Lenny (16iah7h)  
Lenovo - Lenny; get it?

### Holly (Whyte)
My desktop PC is white.

### Basic (tbd)
Planning on creating a basic config to template off of.

## Structure

`Home` and `Hosts` have mirrored folder structures. One folder per host containing a `default.nix` which does the rest.
Configuration that affects more than just one host should happen in Modules. Still a W.I.P. tho, major structure changes are likely to happen.

Minor config changes like installing random applications I intend to just do in `hosts/<host>/default.nix`.
The contents of `configuration.nix` are mostly just set and forget hardware and services.

I decided to have a separate home config per host, to make it a conscious decision what to include. It's off by default so the system can be configured step by step.

## New Hosts
Adding a new host is as simple as creating its respective folder in the `hosts` directory and adding it to nixosConfigurations.

- Required contents of hosts/<hostname>:
  - configuration.nix -> the basic generated file works just fine.
  - hardware-configuration.nix -> generated file.
  - default.nix `{ imports = [ ./configuration.nix ]; }` -> convention used by mkSystem function.

- Required additions to flake.nix:
  - parametrized mkSystem call in nixosConfigurations:
    ```
      myNewHost = mkSystem {
        username = "John";      # needs to match users.users.<username> in configuration.nix
        hostname = "myNewHost"; # needs to match the hosts/<hostname> direcory name
      }
    ```
  - `username` needs to match the user in configuration.nix
  - `hostname` needs to match the name of the directory in hosts

### Configuring after the fact
You can enable home-manager for your host by adding the `enableHomeManager = true` flag as a param to your mkSystem call and adding a folder with default.nix to `home/<hostname>/default.nix`. Go wild from there.

Finally move configs from configuration.nix to modules as you see fit. I usually include them either in flake.nix directly or default.nix
