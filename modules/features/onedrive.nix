{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.onedriver ];

  systemd.user.services.onedriver = {
    description = "OneDrive (onedriver, on-demand FUSE mount)";
    wantedBy = [ "default.target" ];

    # 默认 PATH 不含 /run/wrappers/bin，onedriver 会因此找不到 fusermount3
    enableDefaultPath = false;
    environment.PATH = "/run/wrappers/bin:/run/current-system/sw/bin:${pkgs.coreutils}/bin";

    serviceConfig = {
      Type = "simple"; # onedriver 前台运行
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/OneDrive";
      ExecStart = "${pkgs.onedriver}/bin/onedriver %h/OneDrive";
      # 退出时挂载通常已消失，忽略 fusermount3 的报错
      ExecStopPost = "-/run/wrappers/bin/fusermount3 -uz %h/OneDrive";
      Restart = "on-abnormal";
      RestartSec = 3;
    };
  };
}
