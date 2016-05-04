set -x EDITOR "emacsclient -c"
set -x TERMINAL urxvt
set -x TERM xterm

set -x PATH $PATH ~/.composer/vendor/bin
set -x PATH $PATH /usr/local/MATLAB/MATLAB_Production_Server/R2015a/bin
set -x PATH $PATH $HOME/bin
set -x PATH $PATH $HOME/.i3/scripts

# echo export GTAGSLABEL=pygments >> .profile

# set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
# source $fisher_home/config.fish

# Base16 Shell
# set BASE16_SHELL "$HOME/.zsh.d/base16-shell/base16-default.dark.sh"
# [[ -s $BASE16_SHELL ]] &&
# ($BASE16_SHELL)

# source ./exports.fish
# source ./aliases.fish
# source ./colors.fish

# grc
set -U grcplugin_ls --color -C

# Add fish 2.3 functionality used by fisherman v2
for file in ~/.config/fish/conf.d/*.fish
    source $file
end

# start X at login
# https://wiki.archlinux.org/index.php/Fish#Start_X_at_login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        exec startx -- -keeptty
    end
end
