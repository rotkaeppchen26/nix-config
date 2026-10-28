{ self, lib, ... }: {
  flake.nixosModules.home = { ... }: {
    imports = lib.attrValues (lib.filterAttrs (n: _: lib.hasPrefix "home-" n) self.nixosModules);
  };
}
