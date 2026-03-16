{ pkgs, ... }:

{
  home.packages = [
    (pkgs.wechat.override {
      callPackage =
        path: args:
        pkgs.callPackage path (
          args
          // {
            version = "4.1.1.4";
            src = pkgs.fetchurl {
              url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
              hash = "sha256-XxAvFnlljqurGPDgRr+DnuCKbdVvgXBPh02DLHY3Oz8=";
            };
          }
        );
    })
  ];
}
