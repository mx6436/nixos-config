{
  pkgs,
  ...
}:

let
  lspTools = with pkgs; [
    bash-language-server
    fish-lsp
    golangci-lint
    golangci-lint-langserver
    lua-language-server
    neocmakelsp
    nil
    nixd
    nixfmt
    systemd-language-server
    typescript-language-server
    vscode-json-languageserver
    yaml-language-server
  ];
in

{
  home.packages = with pkgs; [
    claude-code
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
    extraPackages = lspTools;
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
      ps: with ps; [
        nixd
        nixfmt
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
