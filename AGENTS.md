# AGENTS.md

Guidelines for coding agents working in this dotfiles repository.

## Project Overview

This is a personal macOS dotfiles repository containing Lua-based Neovim configuration, Fish shell config, and various tool configurations. The project is NOT designed for easy installation or system independence - symlinks are managed via `setup.sh` and there are many dependencies on installed binaries.

## Repository Structure

```
.dotfiles/
├── nvim/                    # Neovim configuration (Lua-based, 31+ plugins)
│   ├── lua/
│   │   ├── config/          # Core config (autocmds, keymaps, options, lazy)
│   │   └── plugins/         # Individual plugin configurations
│   └── init.lua             # Entry point
├── fish/                    # Fish shell configuration
├── opencode/                # OpenCode AI configuration
│   └── agent/               # Custom agent configs (REVIEW.md)
├── git/                     # Git configuration and aliases
├── tmux/                    # Tmux configuration
├── starship/                # Starship prompt config
├── ghostty/                 # Ghostty terminal config
├── yabai/                   # Yabai window manager config
├── skhd/                    # Simple hotkey daemon config
├── setup.sh                 # macOS setup and symlink script
└── Brewfile                 # Homebrew dependencies
```

## Build/Test Commands

### Linting

```bash
# Check Fish config syntax
fish -n fish/config.fish

# Check Bash script syntax
bash -n setup.sh
```

### Validation

```bash
# Check Brewfile for missing dependencies
brew bundle check
```

No test suite exists for this repository.

## Code Style Guidelines

### Lua (Neovim Configuration)

Follow StyLua configuration in `nvim/stylua.toml`:

- **Column width**: 160
- **Line endings**: Unix
- **Indentation**: 2 spaces
- **Quote style**: Auto-prefer single quotes
- **Call parentheses**: None (e.g., `require 'module'` not `require('module')`)

#### Plugin Configuration Pattern

```lua
return {
  {
    'author/plugin-name',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = { 'dep1', 'dep2' },
    opts = {
      option1 = true,
      option2 = 'value',
    },
    config = function(_, opts)
      require('plugin').setup(opts)
    end,
  },
}
```

#### Naming Conventions

- **Files**: lowercase with hyphens (e.g., `lspconfig.lua`, `grug-far.lua`)
- **Variables**: snake_case (e.g., `local lint_augroup = ...`)
- **Functions**: snake_case (e.g., `function create_symlink()`)
- **Constants**: UPPER_SNAKE_CASE (e.g., `local DOTFILES = ~/.dotfiles`)

#### Keymaps

- Use descriptive descriptions in square brackets: `{ desc = '[f]ormat buffer' }`
- Leader key patterns:
  - `<leader>c*`: Code actions (e.g., `<leader>cf` = format)
  - `<leader>b*`: Buffer operations (e.g., `<leader>bd` = delete)
  - `<leader>t*`: Testing (e.g., `<leader>tr` = run test)
  - `<leader>o*`: Option toggles (e.g., `<leader>of` = format on save)

### Bash Scripts

#### Style

- Use `set -euo pipefail` at the top
- Provide logging with timestamps: `log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >&2; }`
- Check preconditions before executing (e.g., OS check, binary existence)
- Quote variables: `"$variable"` not `$variable`
- Use functions for reusable logic

#### Error Handling

```bash
# Check if command exists
if ! command -v brew >/dev/null 2>&1; then
    log "Error: Homebrew not found"
    exit 1
fi

# Check if file exists
if [ ! -f ~/.config/fish/config.fish ]; then
    log "Warning: Fish config not found"
fi
```

### Fish Shell

- Use Fish syntax, not POSIX shell syntax
- Check status with `if status is-interactive`
- Disable Fish LSP warnings when needed: `# @fish-lsp-disable-next-line 7001`
- Source files from `~/.dotfiles/` using pattern matching

### Configuration Files (TOML/YAML/JSON)

- **TOML**: snake_case keys, Unix line endings
- **YAML**: 2-space indentation
- **JSON/JSONC**: Use Prettier formatting, no trailing commas for JSONC

## File Organization

### Adding New Plugins

1. Create new file in `nvim/lua/plugins/plugin-name.lua`
2. Follow plugin configuration pattern (see above)

### Adding New Keymaps

Add to `nvim/lua/config/keymaps.lua`:

```lua
local map = vim.keymap.set
map('n', '<leader>x', '<cmd>command<CR>', { desc = 'Description' })
```

### Adding New Options

Add to `nvim/lua/config/options.lua`:

```lua
vim.opt.option_name = value
```

### Adding a New Tool Configuration

1. Create directory: `mkdir -p toolname/`
2. Add config files in that directory
3. Update `setup.sh` to symlink it: `create_symlink "$PWD/toolname/" ~/.config/toolname/`
4. Add tool to `Brewfile` if it needs installation

## Important Notes

- **DO NOT** modify `lazy-lock.json` manually - it's managed by lazy.nvim
- **DO NOT** commit `.DS_Store` files or macOS metadata
- **DO NOT** hardcode absolute paths - use `$PWD` or `~/.dotfiles` in scripts
- **AVOID** breaking existing symlinks in `setup.sh`
- **BACKUP** `~/.config` before running `setup.sh` (script does this automatically)

## Resources

- [Lazy.nvim docs](https://github.com/folke/lazy.nvim)
- [Neovim Lua guide](https://neovim.io/doc/user/lua-guide.html)
- [Fish shell docs](https://fishshell.com/docs/current/)
- [StyLua docs](https://github.com/JohnnyMorganz/StyLua)
