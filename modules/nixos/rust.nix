{pkgs, ...}: let
  extensions = ["rustfmt" "rust-analyzer" "clippy" "rust-src"];
  targets = []; # ["arm-unknown-linux-gnueabihf"];
in {
  environment.systemPackages = with pkgs.rust-bin; [
    (stable.latest.default.override
      {
        extensions = extensions;
        targets = targets;
      })
    (selectLatestNightlyWith
      (toolchain:
        toolchain.default.override {
          extensions = extensions;
          targets = targets;
        }))
  ];
}
