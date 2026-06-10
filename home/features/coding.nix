{
  pkgs,
  lib,
  ...
}:

let
  lsp-tools = with pkgs; [
    bash-language-server
    clang-tools
    cmake
    delve # Go
    fish-lsp
    gopls
    golangci-lint-langserver
    lldb
    lua-language-server
    marksman
    neocmakelsp
    nixd
    pyright
    ruff # python
    rust-analyzer
    systemd-language-server
    taplo # toml
    ty # python
    typescript-language-server
    vscode-json-languageserver
    yaml-language-server
  ];

  wrapWithTools =
    pkg:
    pkgs.symlinkJoin {
      name = pkg.name;
      paths = [ pkg ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram "$out/bin/${baseNameOf (lib.getExe pkg)}" \
          --suffix PATH : ${lib.makeBinPath lsp-tools}
      '';
    };
in

{
  home.packages = with pkgs; [
    (wrapWithTools claude-code)
    (wrapWithTools codex)
    (wrapWithTools cursor-cli)
    (wrapWithTools opencode)
    go
    nodejs
    python3
  ];

  programs.helix = {
    enable = true;
    settings.theme = "catppuccin_mocha";
    extraPackages = lsp-tools;
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }
    ];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: lsp-tools);
  };

  programs.direnv.enable = true;

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Wayland support for vscode
  };
}
