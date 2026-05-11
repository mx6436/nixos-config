{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (
      ps: with ps; [
        # Node.js based extensions (prettier, markdownlint, tauri)
        nodejs

        # Go (golang.go)
        go
        gopls
        delve

        # Rust (rust-lang.rust-analyzer, tauri-apps.tauri-vscode)
        rustup

        # TOML (tamasfe.even-better-toml)
        taplo

        # Python (ms-python.black-formatter)
        python3Packages.black

        # C/C++ (ms-vscode.cmake-tools, ms-vscode.cpptools)
        cmake
        gcc
        gdb

        # Debug (vadimcn.vscode-lldb)
        lldb
      ]
    );
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Wayland support for vscode
  };
}
