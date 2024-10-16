set -l DOTFILES ~/.dotfiles
set -l config_files $DOTFILES/**.fish

fish_add_path /opt/homebrew/bin

for config_file in (string match -vr 'config.fish$' $config_files)
    source $config_file
end

if status is-interactive
    fish_vi_key_bindings

    set fish_greeting

    starship init fish | source
    # clear starship modules after exectuting command
    enable_transience
end
