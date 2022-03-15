set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths

set fish_greeting                                 # Supresses fish's intro message
set TERM "xterm-256color"                         # Sets the terminal type
set EDITOR "emacsclient -t -a ''"                 # $EDITOR use Emacs in terminal
set VISUAL "emacsclient -c -a emacs"              # $VISUAL use Emacs in GUI mode

function fish_user_key_bindings
  fish_vi_key_bindings
end

set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

function sudo
	if test "$argv" = !!
	eval command sudo $history[1]
else
	command sudo $argv
	end
end

function search
    command rg -i -C 1 $argv "/home/jeykey/documents/files/archive/org/"
end 

alias ls='exa -al --color=always --group-directories-first'

alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone --recursive'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'

set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_default_branch yes

set -g theme_date_format "+%H:%M:%S"

set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g fish_prompt_pwd_dir_length 0
