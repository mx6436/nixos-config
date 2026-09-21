{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

let
  devTools = with pkgs; [
    marksman
    nixd
    nixfmt
  ];

  lspTools = with pkgs; [
    bash-language-server
    fish-lsp
    golangci-lint
    golangci-lint-langserver
    lua-language-server
    neocmakelsp
    nil
    systemd-language-server
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
        --prefix PATH : ${lib.makeBinPath (devTools ++ [ pkgs.nodejs_latest ])} \
        --set NPM_CONFIG_PREFIX "${config.home.homeDirectory}/.pi/npm"
    '';
  };
in

{
  home.packages = [
    pi-coding-agent
  ];

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    silent = true;
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      editor."soft-wrap".enable = true;
    };
    extraPackages = devTools ++ lspTools;
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
    package = pkgs.vscode.fhsWithPackages (
      ps:
      with ps;
      devTools
      ++ [
        # maa-framework dependencies
        pipewire
        libei
      ]
    );
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Wayland support for vscode
  };
}
