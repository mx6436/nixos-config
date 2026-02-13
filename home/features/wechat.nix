{ pkgs, ... }:

{
  home.packages = [
    (pkgs.wechat.override {
      callPackage =
        path: args:
        pkgs.callPackage path (
          args
          // {
            version = "4.0.1.16";
            src = pkgs.fetchurl {
              url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
              hash = "sha256-Pfl81lNVlMJWyPqFli1Af2q8pRLujcKCjYoILCKDx8U=";
            };
          }
        );
    })
  ];
}
