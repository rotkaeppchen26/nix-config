{
  lib,
  stdenvNoCC,
  src,
  python3,
  gtk4,
  libadwaita,
  gobject-introspection,
  wrapGAppsHook4,
  writeShellApplication,
}: let
  pkg = stdenvNoCC.mkDerivation {
    pname = "kone-aimo";
    version = "0-unstable-${src.lastModifiedDate or "unknown"}";
    inherit src;
    patches = [
      ./_kone-aimo-f13-f24.patch
      ./_kone-aimo-fixes.patch
    ];

    nativeBuildInputs = [
      gobject-introspection
      wrapGAppsHook4
    ];
    buildInputs = [
      gtk4
      libadwaita
      (python3.withPackages (ps: [ps.pygobject3]))
    ];

    installPhase = ''
      runHook preInstall
      install -d $out/share/kone-aimo $out/bin
      cp -r src/aimo tools $out/share/kone-aimo/
      substitute bin/kone-aimo $out/bin/kone-aimo --replace-fail '@LIBDIR@' "$out/share/kone-aimo"
      chmod 755 $out/bin/kone-aimo
      install -Dm644 data/io.github.phiph.KoneAimo.desktop -t $out/share/applications
      install -Dm644 data/io.github.phiph.KoneAimo.svg -t $out/share/icons/hicolor/scalable/apps
      install -Dm644 data/io.github.phiph.KoneAimo.metainfo.xml -t $out/share/metainfo
      install -Dm644 udev/70-roccat-kone-aimo.rules -t $out/lib/udev/rules.d
      runHook postInstall
    '';

    meta = {
      description = "GTK4 configuration app for the ROCCAT Kone Aimo (Remastered / 16K)";
      homepage = "https://github.com/phiph-s/roccat-kone-aimo-linux";
      license = lib.licenses.gpl3Plus;
      mainProgram = "kone-aimo";
      platforms = lib.platforms.linux;
    };
  };

  # Upstream backup.py writes to ./backups relative to the working directory and imports from ./src.
  backup = writeShellApplication {
    name = "kone-aimo-backup";
    runtimeInputs = [python3];
    text = ''
      mkdir -p backups
      PYTHONPATH=${pkg}/share/kone-aimo python3 ${pkg}/share/kone-aimo/tools/backup.py
    '';
  };
in
  pkg.overrideAttrs (old: {
    passthru = (old.passthru or {}) // {inherit backup;};
  })
