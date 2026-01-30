set -x GOBIN $HOME/.local/bin
set -x GOMODCACHE $HOME/.cache/go/mod
set -x GOPATH $HOME/.cache/go

fish_add_path $GOBIN
