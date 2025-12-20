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

  home.packages = with pkgs;
  let
    qgis = pkgs.qgis.override {
      extraPythonPackages = ps: with ps; [
        pillow
        matplotlib
        scipy
        pandas
        scikit-learn
      ];
    };
  in
  [
    starship
    eza
    nixd
    wechat
    qq
    mangohud
    splayer
    typora
    lutris
    papers
    qgis saga
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

  programs.alacritty = {
    enable = true;
    theme = "tokyo_night";
  };

  programs.helix = {
    enable = true;
    settings.theme = "tokyonight_moon";
  };
}
