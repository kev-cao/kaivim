# KaiVim

A Neovim distribution built on [lazy.nvim](https://github.com/folke/lazy.nvim).
KaiVim provides a curated set of plugins and keymaps out of the box while
remaining fully customizable through standard lazy.nvim conventions.

## Prerequisites

**Required:**

- [Neovim](https://neovim.io/) >= 0.10
- [Git](https://git-scm.com/)
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)
- [fzf](https://github.com/junegunn/fzf) (fuzzy finder backend)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (live grep)
- A C compiler (for treesitter parser compilation)

**Optional (for specific features):**

- [Node.js](https://nodejs.org/) — required by Copilot
- [lazygit](https://github.com/jesseduffield/lazygit) — terminal UI for Git
- [xclip](https://github.com/astrand/xclip) — clipboard persistence on exit (Linux)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) or
  [OpenCode](https://github.com/NickvanDyke/opencode.nvim) — AI assistant
- Language-specific tools:
  - **Go:** `gopls`, `goimports`, `gofmt`, `delve` (debugger),
    `golangci-lint` (linter)
  - **TypeScript/JavaScript:** `typescript-language-server`, `prettier`
  - **Lua:** `lua-language-server`
  - **Rust:** `rust-analyzer`, `rustfmt`, `codelldb` (debugger)
  - **C/C++:** `clangd`
  - **Terraform:** `terraform-ls`, `tofu_fmt`

## Installation

### Using the Starter (recommended)

Use the [kaivim-starter](https://github.com/kev-cao/kaivim-starter) template
for a ready-made setup that keeps your customizations in a separate repo:

```sh
git clone https://github.com/kev-cao/kaivim-starter.git ~/.config/nvim
```

Launch Neovim and lazy.nvim will automatically install KaiVim and all plugins.

### Standalone

Clone the repository directly as your Neovim config:

```sh
git clone https://github.com/kev-cao/kaivim.git ~/.config/nvim
```

Launch Neovim and lazy.nvim will automatically install all plugins.

## Configuration

### Standalone

KaiVim is initialized in `init.lua` via `require("kaivim").setup()`. Pass
options to configure the distribution:

```lua
require("kaivim").setup({
  node_path = "/opt/homebrew/bin/node",
  ai_assistant = "claude",
})
```

### Starter

Pass options via the `opts` field on the KaiVim plugin spec in `init.lua`:

```lua
{
  "kev-cao/kaivim",
  import = "kaivim.plugins",
  opts = {
    node_path = "/opt/homebrew/bin/node",
    ai_assistant = "claude",
  },
},
```

| Option | Type | Default | Description |
|---|---|---|---|
| `node_path` | `string` | `"node"` | Path to the Node.js binary, used by Copilot |
| `ai_assistant` | `"claude"\|"opencode"\|nil` | `nil` | Which AI assistant plugin to enable |

### Leader Keys

| Key | Role |
|---|---|
| `,` | `<leader>` |
| `<Space>` | `<localleader>` |

## Customization

KaiVim follows the standard lazy.nvim approach for customization. Place your own
plugin specs in `lua/plugins/` and they will be automatically loaded alongside
the distribution plugins.

### Adding Plugins

Create any `.lua` file under `lua/plugins/`:

```lua
-- lua/plugins/my-plugins.lua
return {
  { "tpope/vim-commentary" },
}
```

### Overriding Plugin Configuration

lazy.nvim merges specs by plugin name. To override a distribution plugin's
options, create a spec with the same plugin URL:

```lua
-- lua/plugins/overrides.lua
return {
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "darker",
    },
  },
}
```

### Disabling Plugins

Set `enabled = false` on any distribution plugin:

```lua
-- lua/plugins/overrides.lua
return {
  { "karb94/neoscroll.nvim", enabled = false },
  { "zbirenbaum/copilot.lua", enabled = false },
}
```

### Overriding Keymaps

lazy.nvim resolves keys by `lhs + mode`, so you can override individual keymaps
while keeping the rest:

```lua
-- lua/plugins/overrides.lua
return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      -- Override just the "search files" keymap
      { "<leader>ff", "<cmd>FzfLua files<CR>", mode = "n", desc = "Search files" },
      -- Remove a keymap by setting rhs to false
      { "<leader>sb", false },
    },
  },
}
```

### LSP Auto-Discovery

Language specs in `lua/kaivim/plugins/lang/lsp/` are automatically discovered at
startup. Each file returns an `LspSpec` table that can include LSP server config,
linters, formatters, and additional plugin specs.

Users can add their own language specs by creating files under
`lua/lang/lsp/` in their config directory (e.g., `~/.config/nvim/lua/lang/lsp/`).
These follow the same `LspSpec` format and are discovered alongside the
distribution's built-in specs:

```lua
-- lua/lang/lsp/python.lua
--- @type LspSpec
return {
  ft = { "python" },
  lsp = {
    pyright = {},
  },
  formatter = { "black" },
}
```

## License

[MIT](LICENSE)
