# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/salman1567/.oh-my-zsh"
export PATH=$PATH:/usr/local/go/bin
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"
export DENO_INSTALL="/home/salman1567/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$PATH:/home/salman1567/bin"

PATH=$PATH:~/.local/bin

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# alias
alias ipe='curl ipinfo.io/ip'
alias ipi='ifconfig | grep "inet"'
alias wget='wget -c '
alias untar='tar -zxvf '
alias ping='ping -c 5'
alias speed='speedtest-cli --server 35020 --simple'
#alias ls='exa --header --long --group'
# bindings

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

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"Which type of animal maintains a constant internal body temperature?
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR=nvim

# Functions


# Pastes output to clbin
function clbin {
	$@ | curl -F 'clbin=<-' https://clbin.com
}

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# starts gnome-session
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

# auto complete
# autoload -Uz compinit
# compinit

# arrow-key driven interface
#zstyle ':completion:*' menu select

# For enabling autocompletion of privileged environments in privileged commands (e.g. if you complete a command starting with sudo, completion scripts will also try to determine your completions with sudo), include:
#zstyle ':completion::complete:*' gain-privileges 1

# history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# cdr (return to previous dir)

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

#zstyle ':completion:*:*:cdr:*:*' menu selection

# zstyle ":completion:*:git-checkout:*" sort false
# zstyle ':completion:*:descriptions' format '[%d]'
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
#zstyle ':completion:*' fzf-search-display true
# on demand rehash from /etc/pacman.d/hooks
zshcache_time="$(date +%s%N)"

#autoload -Uz add-zsh-hook

# rehash_precmd() {
#   if [[ -a /var/cache/zsh/pacman ]]; then
#     local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
#     if (( zshcache_time < paccache_time )); then
#       rehash
#       zshcache_time="$paccache_time"
#     fi
#   fi
# }

# add-zsh-hook -Uz precmd rehash_precmd

# Uses fzf-tab completion https://github.com/Aloxaf/fzf-tab/
#source ~/code/fzf-tab/fzf-tab.plugin.zsh
#source ~/code/fzf-tab-completion/zsh/fzf-zsh-completion.sh
# basic file preview for ls (you can replace with something more sophisticated than head)
zstyle ':completion::*:ls::*' fzf-completion-opts --preview='head {1}'

# preview when completing env vars (note: only works for exported variables)
zstyle ':completion::*:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-completion-opts --preview='eval echo {1}'

# preview a `git status` when completing git add
zstyle ':completion::*:git::git,add,*' fzf-completion-opts --preview='git -c color.status=always status --short'

# if other subcommand to git is given, show a git diff or git log
zstyle ':completion::*:git::*,[a-z]*' fzf-completion-opts --preview='
for arg in {+1}; do
    { git diff --color=always -- "$arg" | git log --color=always "$arg" } 2>/dev/null
done'

# Key binds like those used in graphic file managers may come handy. The first comes back in directory history (Alt+Left), the second let the user go to the parent directory (Alt+Up). They also display the directory content.

cdUndoKey() {
  popd
  zle       reset-prompt
  echo
  ls
  zle       reset-prompt
}

cdParentKey() {
  pushd ..
  zle      reset-prompt
  echo
  ls
  zle       reset-prompt
}

zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[[1;3A'      cdParentKey
bindkey '^[[1;3D'      cdUndoKey


# fish syntax highlighting and autosuggestions
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh


if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PS1='$ '
fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval $(starship init zsh)
