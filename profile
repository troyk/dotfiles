export GOROOT=/usr/local/go
export GOPATH=~/Projects/go 
export PATH="$HOME/bin:$HOME/.rbenv/bin:$PATH:$GOPATH/bin"
export PGDATA="/usr/local/pgsql/data"

# gcc on OSX >= 10.8
export CC=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
export CXX=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++


# ruby/rails dev env
eval "$(rbenv init -)"
alias rs="rails server"
alias rc="rails console"
alias rr="rails runner"
alias gs="git status"
alias gc="git commit"

# krutted prompt (with git completion)
# following get config commands are required to make the love work
# git config --global color.branch auto
# git config --global color.diff auto
# git config --global color.status auto
source ~/.git-completion.bash
source ~/.git-prompt.bash
GIT_PS1_SHOWDIRTYSTATE=true
#PS1='\[\033[32m\]\u\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
PS1='\[\033[32m\]\u\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]⚡ '

#make things beautiful
# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'
