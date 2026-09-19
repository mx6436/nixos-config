{ pkgs, ... }:

{
  home.packages = [
    (pkgs.wechat.override {
      callPackage =
        path: args:
        pkgs.callPackage path (
          args
          // {
            version = "latest";
            src = pkgs.fetchurl {
              url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
              hash = "sha256-T1StKQLs1vb9xWgLc1R/gNVCO/RwsBI3pXmi5bPK7us=";
            };
          }
        );
    })
  ];
}
