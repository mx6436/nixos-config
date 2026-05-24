{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings.theme = "catppuccin_mocha";
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }
    ];
    extraPackages = with pkgs; [
      bash-language-server
      clang-tools
      delve # Go
      fish-lsp
      gopls
      golangci-lint-langserver
      lldb
      lua-language-server
      marksman
      neocmakelsp
      nixd
      ruff # python
      rust-analyzer
      systemd-language-server
      taplo # toml
      ty # python
      typescript-language-server
      vscode-json-languageserver
      yaml-language-server
    ];
  };
}
