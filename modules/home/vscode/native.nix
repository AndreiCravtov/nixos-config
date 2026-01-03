# For "native" languages like C/C++, Rust, etc.
{pkgs, ...}: {
  # Config
  programs.vscode.profiles.default = {
    # TODO: possibly need to set up paths in configurations
    extensions =
      (with pkgs.vscode-marketplace-release; [
        ms-vscode.cpptools
        ms-vscode.cpptools-themes
        ms-vscode.cmake-tools
        webfreak.debug # Is this doing same thing as LLDB??

        # Rust
        rust-lang.rust-analyzer # TODO: break out into its own thing ??
      ])
      ++ (with pkgs.vscode-extensions; [
        vadimcn.vscode-lldb
      ]);
  };
}
