autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "


autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# include hidden files in autocomplete:
_comp_options+=(globdots)

# vim mode
bindkey -v

# aliasses
# use neovim for vim if present.
command -v nvim >/dev/null && alias vim="nvim" vimdiff="nvim -d"

# lsd for ls
alias ls='lsd'
alias l='ls -l'
alias ll="ls -lahF"
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

alias tree='tree -CFa -I ".git" --dirsfirst'
