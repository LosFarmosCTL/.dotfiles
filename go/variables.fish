set -x GOBIN $HOME/.local/bin
set -x GOMODCACHE $HOME/.cache/go/mod
set -x GOSUMDB $HOME/.cache/go/sumdb

fish_add_path $GOBIN
