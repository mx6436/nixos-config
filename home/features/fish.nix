{ pkgs, ... }:

{
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
      if status is-interactive && string match -q "*kitty*" $TERM
          starship init fish | source
      end
    '';
  };
}
