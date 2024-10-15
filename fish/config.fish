set -l DOTFILES ~/.dotfiles
set -l config_files $DOTFILES/**.fish

fish_add_path /opt/homebrew/bin

for config_file in (string match -vr 'config.fish$' $config_files)
    source $config_file
end

if status is-interactive
    # Set the cursor shapes for the different vi modes.
    set fish_cursor_default     block      blink
    set fish_cursor_insert      line       blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_visual      block

    set fish_vi_force_cursor

    set fish_greeting

    starship init fish | source
end
