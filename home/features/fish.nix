{ pkgs, ... }:

{
  # launch fish unless the parent process is already fish
  programs.bash = {
    enable = true;
    initExtra = ''
      # Keep interactive terminals auto-switching to fish.
      # Skip only Copilot-run shells (history disabled).
      if [[ -z ''${VSCODE_PREVENT_SHELL_HISTORY} && $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
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
      set EDITOR hx

      # muticd
      function multicd
          echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
      end
      abbr --add dotdot --regex '^\.\.+$' --function multicd

      # Alt+Backspace deletes one path component instead of the whole token
      bind alt-backspace backward-kill-path-component
      bind ctrl-alt-h backward-kill-path-component

      alias ls 'eza -la --group-directories-first --header --icons --git'
      alias ll 'eza -l --group-directories-first --header --icons'

      # init starship
      if status is-interactive && string match -q "*kitty*" $TERM
          starship init fish | source
      end
    '';
  };
}
