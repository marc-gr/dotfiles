export ZPLUG_HOME=~/.zplug
export GOPATH=~/dev/go
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:$GOPATH/bin:~/.rvm/bin"
export EDITOR='vim'
export KEYTIMEOUT=1
export DISABLE_AUTO_TITLE=true

alias binme="curl --silent -X POST http://requestb.in/api/v1/bins | jq -r '\"http://requestb.in/\(.name)?inspect\"'"

function code {
        if [[ $# = 0  ]]
	then
		open -a "Visual Studio Code"
	else
	        local argPath="$1"
		[[ $1 = /*  ]] && argPath="$1" || argPath="$PWD/${1#./}"
		open -a "Visual Studio Code" "$argPath"
	fi
}

timestamp() {
	date +"%s"
}

source $ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-autosuggestions"

zplug "urbainvaes/fzf-marks"

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/brew", from:oh-my-zsh
zplug "plugins/brew-cask", from:oh-my-zsh
zplug "plugins/composer", from:oh-my-zsh
zplug "plugins/osx", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

# Liquid prompt
LP_ENABLE_TIME=1
LP_USER_ALWAYS=1
zplug "nojhan/liquidprompt"

zplug install

zplug load


# FZF
if [[ -f ~/.fzf.zsh  ]]; then
	source ~/.fzf.zsh
fi
export FZF_DEFAULT_COMMAND='ag -g ""'
