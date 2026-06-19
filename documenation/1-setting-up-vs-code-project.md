# Setting Up VS Code for This R/Quarto Project

This project uses VS Code's R extension with an explicit Windows path to `R.exe` and project-local `renv` activation.

The current fixed `.vscode/settings.json` is:

```json
{
  "r.rterm.windows": "C:\\\\Program Files\\\\R\\\\R-4.5.2\\\\bin\\\\x64\\\\R.exe",
  "r.rterm.linux": "R",
  "r.rterm.mac": "R",
  "r.alwaysUseActiveTerminal": true,
  "r.bracketedPaste": true,
  "r.sessionWatcher": true
}
```

The important Windows fix is `r.rterm.windows`: it points VS Code directly at the installed R executable instead of relying on `R.exe` being available on `PATH`.

Because `r.alwaysUseActiveTerminal` is still enabled, **Run Cell sends R code to the currently active terminal**. If another terminal was clicked recently, VS Code may send the code there instead of the intended R session.

## Recommended Workflow

1. Open the correct R terminal first:

   - Use the Command Palette.
   - Run `R: Create R terminal`.
   - Confirm the terminal starts from this project root and loads `renv/activate.R`.

2. Click inside that R terminal once so VS Code treats it as the active terminal.

3. Return to the `.qmd` file and click **Run Cell**.

4. If code still goes to the wrong place, close extra terminals and create one fresh R terminal from the project root.

## Full Document Rendering

For a full-document check, use Quarto directly:

```bash
quarto render sample_1.qmd
```

This avoids VS Code terminal-targeting behavior entirely.

## Optional Setting Change

If you want the R extension to stop using whichever terminal is active, change:

```json
"r.alwaysUseActiveTerminal": true
```

to:

```json
"r.alwaysUseActiveTerminal": false
```

That usually makes the R extension manage its own R terminal instead of relying on the currently active terminal.
