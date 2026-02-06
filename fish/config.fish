fish_add_path /opt/homebrew/bin

if status is-interactive
    fish_vi_key_bindings

    bind -M default \cr fzfr
    bind -M insert \cr fzfr

    set fish_greeting

    tirith init --shell fish | source

    zoxide init fish | source

    starship init fish | source
    # clear starship modules after exectuting command
    # @fish-lsp-disable-next-line 7001
    enable_transience
end

set -l DOTFILES ~/.dotfiles
set -l config_files $DOTFILES/**.fish

for config_file in (string match -vr 'config.fish$' $config_files)
    source $config_file
end
