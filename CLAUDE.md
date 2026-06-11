# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project context

- This is a Nix flake for a NixOS system; the primary host is `nixosConfigurations.magicbook` on `x86_64-linux`.
- Home Manager is integrated as a NixOS module, with user `mx` imported from `users/mx/home.nix`; do not treat Home Manager as a separate standalone config unless asked.
- The repository uses the flake formatter `nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree`; format Nix files with `nix fmt`.

## Verification commands

- Format: `nix fmt`
- Evaluate the system derivation without switching the live machine: `nix eval .#nixosConfigurations.magicbook.config.system.build.toplevel.drvPath`
- Stronger build check without creating a result symlink: `nix build .#nixosConfigurations.magicbook.config.system.build.toplevel --no-link`
- Only run live-system commands such as `sudo nixos-rebuild switch --flake .#magicbook` when the user explicitly asks to apply the configuration.

## Gotchas

- Do not change `system.stateVersion` or `home.stateVersion` casually; those values are compatibility anchors and should only change after explicit migration review.
- Secure Boot is managed through Lanzaboote with `boot.lanzaboote.pkiBundle = "/var/lib/sbctl"`; avoid re-enabling plain `systemd-boot` unless intentionally changing the boot setup.
