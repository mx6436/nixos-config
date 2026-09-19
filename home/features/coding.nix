{
  config,
  pkgs,
  pkgs-unstable,
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
    nil
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

  pi-coding-agent = pkgs.symlinkJoin {
    name = "pi-coding-agent";
    paths = [ pkgs-unstable.pi-coding-agent ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/${baseNameOf (lib.getExe pkgs-unstable.pi-coding-agent)}" \
        --prefix PATH : ${lib.makeBinPath (lsp-tools ++ [ pkgs.nodejs_latest ])} \
        --set NPM_CONFIG_PREFIX "${config.home.homeDirectory}/.pi/npm"
    '';
  };
in

{
  home.packages = [
    pi-coding-agent
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
