{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mx";
  home.homeDirectory = "/home/mx";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

  home.packages =
  let
    wechat = pkgs.wechat.override {
      callPackage = path: args: pkgs.callPackage path (args // {
        src = pkgs.fetchurl {
          url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
          hash = "sha256-+r5Ebu40GVGG2m2lmCFQ/JkiDsN/u7XEtnLrB98602w=";
        };
      });
    };
  in
  with pkgs; [
    starship
    eza
    nixd
    wechat
    qq
    mangohud
    splayer
    lutris
    papers
    showtime
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "mx6436";
      user.email = "mx6436@foxmail.com";
    };
  };

  # launch fish unless the parent process is already fish
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      # muticd
      function multicd
          echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
      end
      abbr --add dotdot --regex '^\.\.+$' --function multicd

      alias ls 'eza --group-directories-first'
      alias ll 'eza -l --group-directories-first'
      alias la 'eza -la --group-directories-first'

      # init starship
      if status is-interactive
          starship init fish | source
      end
    '';
  };

  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10.5; 
    };

    themeFile = "Catppuccin-Mocha"; 

    settings = {
      # 隐藏 Kitty 自带的标题栏和边框，让 Niri 的 focus-ring 全权接管
      hide_window_decorations = "yes";

      # 内边距 (Padding)
      # Niri 的 gaps 是 3，focus-ring 是 2。
      # 建议 Kitty 内部至少留 4-6px 的空间，否则文字贴着圆角/边框会很难看。
      window_padding_width = 5;

      # --- 视觉与透明度 ---
      
      # 如果你喜欢半透明 (配合 Niri 的现代感)
      # 1.0 是不透明，0.95 是轻微透明
      background_opacity = "0.95";
      
      # --- Wayland 性能 ---
      linux_display_server = "wayland";
      
      # 禁用响铃声音 (个人建议，Niri 环境下有时候挺吵)
      enable_audio_bell = "no";
    };
  };

  programs.helix = {
    enable = true;
    settings.theme = "catppuccin_mocha";
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [
      rustup zlib openssl.dev pkg-config # needed for rust lang server and rust-analyzer extension
    ]);
  };
}
