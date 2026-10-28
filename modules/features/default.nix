{
  self, lib, ...
}: {
  flake.nixosModules.features = { ... }: {
    imports = lib.attrValues (lib.filterAttrs (n: _: lib.hasPrefix "feature-" n) self.nixosModules);
  };
}
