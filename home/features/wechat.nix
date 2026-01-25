{ pkgs, ... }:

{
  home.packages = [
    (pkgs.wechat.override {
      callPackage =
        path: args:
        pkgs.callPackage path (
          args
          // {
            src = pkgs.fetchurl {
              url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
              hash = "sha256-+r5Ebu40GVGG2m2lmCFQ/JkiDsN/u7XEtnLrB98602w=";
            };
          }
        );
    })
  ];
}
