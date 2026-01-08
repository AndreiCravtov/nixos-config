# Patches equibop icon generation
# SEE: https://github.com/NixOS/nixpkgs/issues/453095#issuecomment-3711936805
{...}: self: super: {
  equibop = super.equibop.overrideAttrs (_: {
    postBuild = ''
      pushd build
      ${super.lib.getExe' super.python313Packages.icnsutil "icnsutil"} e icon.icns
      popd
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/opt/Equibop
      cp -r dist/*unpacked/resources $out/opt/Equibop/

      for file in build/icon.icns.export/*\@2x.png; do
        base=''${file##*/}
        size=''${base/x*/}
        targetSize=$((size * 2))
        install -Dm0644 $file $out/share/icons/hicolor/''${targetSize}x''${targetSize}/apps/equibop.png
      done

      runHook postInstall
    '';
  });
}
