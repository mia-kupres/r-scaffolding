# VS Code Keyboard Shortcuts for Quarto QMD Files

For `.qmd` files in VS Code on Windows, the useful shortcuts are mostly VS Code shortcuts plus commands provided by the R and Quarto extensions.

| Action | Shortcut |
| --- | --- |
| Open Command Palette | `Ctrl+Shift+P` |
| Open Keyboard Shortcuts | `Ctrl+K Ctrl+S` |
| Toggle integrated terminal | `` Ctrl+` `` |
| Create new terminal | `Ctrl+Shift+`` |
| Run current R line or selection | `Ctrl+Enter` |
| Run current cell or chunk and advance | Often `Shift+Enter`, depending on extension keybindings |
| Save file | `Ctrl+S` |
| Find in file | `Ctrl+F` |
| Comment or uncomment line | `Ctrl+/` |
| Format document | `Shift+Alt+F` |
| Open Markdown preview | `Ctrl+Shift+V` |
| Open preview to the side | `Ctrl+K V` |

## Quarto Commands

For Quarto-specific actions, the most reliable method is to use the Command Palette:

1. Press `Ctrl+Shift+P`.
2. Type `Quarto`.
3. Choose commands such as:
   - `Quarto: Preview`
   - `Quarto: Render`
   - `Quarto: Render Document`
   - `Quarto: Run Cell`, if available

## Customize or Confirm Shortcuts

To see the exact shortcuts configured on your machine:

1. Press `Ctrl+K Ctrl+S`.
2. Search for:
   - `quarto`
   - `r.run`
   - `run cell`
   - `terminal`

## Active Terminal Note

This project currently uses:

```json
"r.alwaysUseActiveTerminal": true
```

With that setting enabled, shortcuts such as `Ctrl+Enter` send code to the currently active terminal. Click inside the correct R terminal first, then return to the `.qmd` file and run the cell.
