
export LANG=ja_JP.UTF-8
export VTE_CJK_WIDTH=1
export TERM=xterm-256color

#補完用のプラグイン
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

#色
eval $(gdircolors /Users/angel/.zsh/dircolors-solarized/dircolors.ansi-dark)
export LS_COLORS

# completion
autoload -U compinit && compinit

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' group-name ''

zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

setopt correct
setopt nobeep
setopt auto_param_slash
setopt mark_dirs
setopt list_types
setopt auto_menu
setopt auto_param_keys
setopt interactive_comments
setopt magic_equal_subst

setopt complete_in_word
setopt always_last_prompt

setopt print_eight_bit
setopt extended_glob
unsetopt case_glob
setopt menu_complete

zstyle ':completion:*:cd:*' ignore-parents parent pwd

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


# 色設定
autoload -U colors; colors

#履歴関連
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000000
setopt hist_no_store
setopt inc_append_history
setopt share_history
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_ignore_all_dups
setopt hist_no_store
setopt pushd_ignore_dups

# PCRE 互換の正規表現を使う
setopt re_match_pcre

#区切り文字の設定
autoload -U select-word-style
select-word-style bash
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# プロンプト指定
PROMPT="
%{${fg[yellow]}%}%~%{${reset_color}%}
%(?.%{[38;5;006m%}.%{$fg[blue]%})%(?!(*'-') <!(*;-;%)? <)%{${reset_color}%} "

PROMPT2='[?] > '

SPROMPT="%{$fg[red]%}%{$suggest%}(*'~'%)? < もしかして %B%r%b %{$fg[red]%}かな? [そう!(y), 違う!(n),a,e]:${reset_color} "

#git プロンプト
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

#一般
setopt list_packed
setopt auto_cd

bindkey -e
bindkey '^o' autosuggest-accept

#コマンドのsyntax-highlight
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#alias
alias sl='gls --color=auto'
alias ls='gls --color=auto'

ssh-add -K ~/.ssh/github_thekohomlily >/dev/null 2>&1

#パス関連

#goのパス
if [ -x "`which go`" ]; then
    export GOROOT=`go env GOROOT`
    export GOPATH=$HOME/code/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

#関数
function aizussh()
{
    ssh -Y -C -l s1240198 sshgate.u-aizu.ac.jp
}

function cd()
{
    builtin cd $@ && ls;
}
