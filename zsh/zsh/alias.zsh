alias ls='ls --color=auto'
alias ll='ls -la'

alias grep='grep --color'

alias pull="git pull --rebase"

alias vim="nvim -O"
alias v=vim
alias vimdiff="vim -d"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias cdg='cd $(git rev-parse --show-toplevel)'

alias o='xdg-open'

alias serve='caddy -port 8000 browse "log stdout"'

alias av='aws-vault'
alias ave='aws-vault exec'
# alias pim="aws-vault exec --assume-role-ttl=1h sd -- pim"
# alias kim="aws-vault exec --assume-role-ttl=1h sd -- pim k8s"

alias tf=terraform
alias k=kubectl

alias hg="kitty +kitten hyperlinked_grep"
alias rg="rg -S"
