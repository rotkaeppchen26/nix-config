# Kone Aimo for NixOS

Packages the [Kone Aimo app](https://github.com/phiph-s/roccat-kone-aimo-linux)
at commit `e3d36fe`, with two patches:

- `_kone-aimo-f13-f24.patch`: adds F13 to F24 to every button menu.
- `_kone-aimo-fixes.patch`: fixes the crash on profile switch and treats short status
  replies as busy. Apply and profile errors print a traceback to the terminal.

## Files

| File | Purpose |
|---|---|
| `_kone-aimo-package.nix` | Package, plus the `kone-aimo-backup` helper |
| `_kone-aimo-f13-f24.patch`, `_kone-aimo-fixes.patch` | Patches for the package |
| `kone-aimo-standalone.nix` | Plain NixOS module (option A) |
| `kone-aimo.nix` | Dendritic feature module (option B) |
| `nixos-dendritic.diff` | Full change to the nixos-dendritic sandbox repo (option C) |

Keep all files in one directory. The modules load the package and the patches
by relative path.

## Option A: plain configuration.nix

1. Copy this directory to `/etc/nixos/kone-aimo/`.
2. Add the module to `imports` in `/etc/nixos/configuration.nix`:

   ```nix
   imports = [
     ./hardware-configuration.nix
     ./kone-aimo/kone-aimo-standalone.nix
   ];
   ```

3. Remove the old hand-typed `package.nix` and its lines from `configuration.nix`.
4. Run `sudo nixos-rebuild switch`.

## Option B: dendritic flake

1. Copy `kone-aimo.nix`, `_kone-aimo-package.nix` and both patches to
   `modules/features/hardware/`. Do not copy `kone-aimo-standalone.nix`;
   import-tree would load it as a flake-parts module.
2. Add the input to `flake.nix`:

   ```nix
   kone-aimo-src = {
     url = "github:phiph-s/roccat-kone-aimo-linux/e3d36feb6ad4677f82580503120c1121722b428f";
     flake = false;
   };
   ```

3. Enable it in the host: `features.hardware.kone-aimo.enable = true;`
4. Run `git add -N modules/features/hardware/*kone-aimo*`, then `nix flake lock`.
5. Run `sudo nixos-rebuild switch --flake .#<host>`.

## Option C: the nixos-dendritic sandbox repo

In a clean checkout of that repo, run `git apply nixos-dendritic.diff`.
The diff contains the files above, the flake input, the lock entry, the desktop
host toggle and the README section.

## After the switch

1. Unplug the mouse and plug it in again.
2. Run `kone-aimo-backup` in a directory of your choice. It writes `backups/`.
3. Start the app from a terminal: `PYTHONFAULTHANDLER=1 kone-aimo`.

The app supports USB ID `1e7d:2e2c` only. Check with `lsusb | grep 1e7d`.
