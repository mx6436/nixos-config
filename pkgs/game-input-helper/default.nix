{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "game-input-helper";

  runtimeInputs = with pkgs; [
    zenity
    wl-clipboard
    xdotool
    fcitx5
  ];

  text = ''
    # 1. 休眠 0.6 秒 (等待 zenity 窗口弹出并获得焦点)
    # 2. 调用 fcitx5-remote -o (打开输入法/切换到中文)
    (sleep 0.6 && fcitx5-remote -s wbx) &
  
    # 获取输入
    # 2>/dev/null 屏蔽一些 GTK 在 Wayland 下可能的报错噪音
    INPUT_TEXT=$(zenity --entry --title="游戏输入助手" --text="请输入文本:" --width=400 2>/dev/null)

    if [ -z "$INPUT_TEXT" ]; then
      exit 0
    fi

    # 写入剪贴板 (Wayland 方式)
    # --type text/plain 显式指定类型通常更稳健
    echo -n "$INPUT_TEXT" | wl-copy --type text/plain

    # 等待焦点切换
    # 窗口关闭后，焦点需要一点时间回到游戏窗口
    # sleep 0.1

    # 模拟粘贴 (Ctrl+V)
    xdotool key --clearmodifiers ctrl+v
  '';
}
