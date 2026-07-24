# @fish-lsp-disable-next-line 4004
function yoink
  osascript -e "set the clipboard to (POSIX file \"$PWD/$argv[1]\")"
end
