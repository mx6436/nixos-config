{
  pkgs,
  ...
}:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    dbus
    libei
    libgcc
    pipewire
    # Tauri
    cairo
    gdk-pixbuf
    glib
    gtk3
    libayatana-appindicator
    libsoup_3
    webkitgtk_4_1
  ];
}
