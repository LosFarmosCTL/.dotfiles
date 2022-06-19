if status is-interactive
    set -l DOTFILES ~/.dotfiles
    set -l config_files $DOTFILES/**.fish

    for config_file in (string match -vr 'config.fish$' $config_files)
        source $config_file
    end

    # Set the cursor shapes for the different vi modes.
    set fish_cursor_default     block      blink
    set fish_cursor_insert      line       blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_visual      block

    starship init fish | source
end
