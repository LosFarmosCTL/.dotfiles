abbr -ag oc opencode

# @fish-lsp-disable-next-line 4004
function ??
  opencode mini -m openai/gpt-6-luna --prompt "$argv"
end
