{ ... }:

{
  # See https://nixos.wiki/wiki/WayDroid
  #
  # To remove waydroid, run
  # ```
  # sudo systemctl stop waydroid-container
  # sudo rm -r /var/lib/waydroid/* ~/.local/share/waydroid
  # ```
  virtualisation.waydroid.enable = true;

  networking.firewall = {
    trustedInterfaces = [ "waydroid0" ];
  };
}
