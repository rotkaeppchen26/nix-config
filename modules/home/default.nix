{ self, lib, ... }: {
  flake.nixosModule.home = { ... }: {
    imports = lib.attrValues (lib.filterAttrs (n: _: lib.hasPrefix "home-" n) self.nixosModules);
  };
}
