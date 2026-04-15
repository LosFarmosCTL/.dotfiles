abbr -ag oc opencode

# @fish-lsp-disable-next-line 4004
function ??
  set -l prompt "You are a terminal assistant.
  If needed for the task, you are allowed to explore the current directory to gather relevant context,
  then deliver ONE single shell command that the user can run to solve their request.

  CRITICAL - you should use pbcopy via the shell tool to store the generated command in the clipboard, for example: echo \"<command>\" | pbcopy
  [optional: include 1-3 line explanation if flags are obscure, don't include lengthy explanations about tradeoffs/alternatives]

  - Make sure to escape everything properly inside of the echoed string
  - Do not output markdown formatting, stick to plain text

  This is the users request: $argv
  "

  opencode run -m openai/gpt-5.4 "$prompt"
end
