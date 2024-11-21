# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates

plugins=(
	git	
	zsh-autosuggestions
)


source $ZSH/oh-my-zsh.sh
path+=('~/.local/bin/')
export EDITOR="nvim"
alias v="nvim"
alias c="cargo"
alias m="make"
alias markdownlint="mdl"
alias g="git"
alias lg="lazygit"
alias top="btop"

alias cat="bat"
alias ls="eza --color=always --long --git --icons=always --no-user --no-permissions"

eval "$(starship init zsh)"

eval $(thefuck --alias)
eval $(thefuck --alias fk)

eval "$(zoxide init zsh)"

eval "$(zellij setup --generate-auto-start zsh)"

# TODO: FZF broken
# source <(fzf --zsh)

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#
# source ~/.fzf-git/fzf-git.sh
#
# show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
#
# export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
# export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
#
# # Advanced customization of fzf options via _fzf_comprun function
# # - The first argument to the function is the name of the command.
# # - You should make sure to pass the rest of the arguments to fzf.
# _fzf_comprun() {
#   local command=$1
#   shift
#
#   case "$command" in
#     cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
#     export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
#     ssh)          fzf --preview 'dig {}'                   "$@" ;;
#     *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
#   esac
# }
#
# TODO: ZFS issues -> daemon maybe?
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# [ -f "/home/jeykey/.ghcup/env" ] && . "/home/jeykey/.ghcup/env" # ghcup-env
