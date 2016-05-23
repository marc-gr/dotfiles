export ZPLUG_HOME=$HOME/.zplug
export GOPATH=$HOME/dev/go
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:$GOPATH/bin:$HOME/.rvm/bin"
export EDITOR='vim'
export KEYTIMEOUT=1
export DISABLE_AUTO_TITLE=true

alias _='sudo'
alias tmux='tmux -2'
alias ogc="killall 'Google Chrome'; sleep 1; open -a 'Google Chrome' --args --ignore-certificate-errors --disable-web-security"
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

if [[ -f $ZPLUG_HOME/zplug  ]]; then
	source $ZPLUG_HOME/init.zsh
	zplug "zplug/zplug"

	zplug "zsh-users/zsh-autosuggestions", nice:10
	
	zplug "urbainvaes/fzf-marks", nice:10

	zplug "zsh-users/zsh-syntax-highlighting", nice:10
	zplug "zsh-users/zsh-history-substring-search", nice:10

	zplug "plugins/git", from:oh-my-zsh, nice:10
	zplug "plugins/tmux", from:oh-my-zsh, nice:10
	zplug "plugins/brew", from:oh-my-zsh, nice:10
	zplug "plugins/brew-cask", from:oh-my-zsh, nice:10
	zplug "plugins/composer", from:oh-my-zsh, nice:10
	zplug "plugins/osx", from:oh-my-zsh, nice:10, if:"[[ $OSTYPE == *darwin* ]]"

	# Liquid prompt
	LP_ENABLE_TIME=1
	LP_USER_ALWAYS=1
	zplug "nojhan/liquidprompt", nice:10

	if ! zplug check --verbose; then
    	printf "Install? [y/N]: "
    	if read -q; then
        	echo; zplug install
    	fi
	fi
	
	zplug load
fi

# FZF
if [[ -f ~/.fzf.zsh  ]]; then
	source ~/.fzf.zsh
fi
export FZF_TMUX=1
export FZF_DEFAULT_COMMAND='ag -g ""'

source /usr/local/opt/autoenv/activate.sh
