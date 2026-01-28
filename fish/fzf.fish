function fzfr --description "Fuzzy-find and insert a command from history"
    # Get the current text in the prompt buffer
    set -l current_buffer (commandline)

    # history --null: handles multi-line commands
    # fzf --read0: reads those null-terminated commands
    # --query: pre-fills the search with what you already typed
    set -l selection (history --null | fzf --read0 \
        --height=40% \
        --layout=reverse \
        --border \
        --query="$current_buffer" \
        --preview='echo {} | fish_indent --ansi' \
        --preview-window='up:3:wrap' \
        --header='[History Search]')

    # If the user made a selection (status 0)
    if test $status -eq 0
        # Replace the current buffer with the selection
        commandline -rt -- $selection
    end

    # Ensure the prompt redrawing is clean
    commandline -f repaint

    # Since you use vi-mode: automatically switch back to Insert mode
    # so you can immediately edit/run the command.
    set -g fish_bind_mode insert
end
