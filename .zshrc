#  $$\   $$\                                                         $$$$$$$$\  $$$$$$\  $$\   $$\
#  $$ |  $$ |                                                        \____$$  |$$  __$$\ $$ |  $$ |
#  \$$\ $$  | $$$$$$\  $$$$$$$\   $$$$$$\  $$\   $$\  $$$$$$\            $$  / $$ /  \__|$$ |  $$ |
#   \$$$$  / $$  __$$\ $$  __$$\ $$  __$$\ $$ |  $$ |$$  __$$\          $$  /  \$$$$$$\  $$$$$$$$ |
#   $$  $$<  $$$$$$$$ |$$ |  $$ |$$$$$$$$ |$$ |  $$ |$$$$$$$$ |        $$  /    \____$$\ $$  __$$ |
#  $$  /\$$\ $$   ____|$$ |  $$ |$$   ____|$$ |  $$ |$$   ____|       $$  /    $$\   $$ |$$ |  $$ |
#  $$ /  $$ |\$$$$$$$\ $$ |  $$ |\$$$$$$$\ \$$$$$$$ |\$$$$$$$\       $$$$$$$$\ \$$$$$$  |$$ |  $$ |
#  \__|  \__| \_______|\__|  \__| \_______| \____$$ | \_______|      \________| \______/ \__|  \__|
#                                          $$\   $$ |
#                                          \$$$$$$  |
#                                           \______/

#!/bin/sh
TERM=xterm-256color

# Prompt indent
ZLE_RPROMPT_INDENT=0

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Nord theme
test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)

/home/xeneye/Scripts/lol Xeneye

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|[._-]=* l:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# Custom ZSH Binds
bindkey '^ ' autosuggest-accept

# Load aliases and shortcuts if existent.
[ -f "$HOME/.zsh/aliasrc" ] && source "$HOME/.zsh/aliasrc"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History Configuration
HISTSIZE=10000			#How many lines of history to keep in memory
HISTFILE=~/.cache/zsh/history	#Where to save history to disk
HISTDUP=erase			#Erase duplicates in the history file
SAVEHIST=10000			#Number of history entries to save to disk
setopt    appendhistory		#Append history to the history file (no overwriting)
setopt    sharehistory		#Share history across terminals
setopt    incappendhistory	#Immediately append to the history file, not just when a term is killed

# Load ; should be last.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/autojump/autojump.zsh 2>/dev/null
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/doc/pkgfile/command-not-found.zsh
