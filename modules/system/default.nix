{ self, ... }: {
  flake.nixosModules.system = { ... }: {
    imports = with self.nixosModules; [
      bootloader
      networking
      nix-settings
      locale
      packages
      audio
    ];
  };
}
