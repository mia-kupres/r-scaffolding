# Repository Guidelines

## Project Structure & Module Organization

This repository contains an R/Quarto supplement for *Time Series Analysis and Applications Using the R Statistical Package*. Keep Quarto documents at the repository root unless the project grows enough to justify topic subdirectories. The current example is `sample_1.qmd`. Project dependency metadata lives in `DESCRIPTION`, while reproducible package state is managed by `renv.lock` and files under `renv/`. Local editor defaults are in `.vscode/settings.json`.

Generated render outputs such as `*.html`, `*.pdf`, `*.docx`, `*_files/`, and Quarto caches are intentionally ignored. Do not commit local `renv/library/` contents.

## Build, Test, and Development Commands

- `bash setup-r-env.sh`: bootstraps `renv`, restores packages from `renv.lock`, installs detected dependencies, and snapshots the environment.
- `bash setup-r-env.sh ggplot2,dplyr,readr`: restores the environment and adds explicit packages.
- `quarto render sample_1.qmd`: renders the sample Quarto document.
- `Rscript path/to/script.R`: runs standalone R scripts from the project root so `renv/activate.R` is loaded.

## Coding Style & Naming Conventions

Use clear, reproducible R code inside Quarto chunks. Prefer lower_snake_case for new `.qmd`, `.R`, and data-related filenames, for example `chapter_02_arima.qmd`. Keep YAML front matter explicit about `format` and `execute` options. Follow the existing R formatting style: four-space indentation for wrapped function arguments, spaces around assignment and operators, and descriptive object names.

## Testing Guidelines

There is no formal test suite yet. For Quarto changes, verify by rendering the changed document with `quarto render <file>.qmd` and checking that chunks run without warnings unless warnings are part of the example. If R package-style tests are added later, use `testthat` under `tests/testthat/` with files named `test-*.R`.

## Commit & Pull Request Guidelines

This repository has no commits yet, so no existing commit convention is established. Use concise, imperative commit subjects such as `Add ARIMA supplement example` or `Update renv dependencies`. Pull requests should describe the changed supplement content, list any dependency changes to `DESCRIPTION` or `renv.lock`, and include rendered output screenshots or notes when Quarto output changes.

## Agent-Specific Instructions

Preserve the `renv` workflow. When adding packages, update `DESCRIPTION` when they are project dependencies and run the setup script so `renv.lock` stays consistent. Avoid committing generated render artifacts unless a maintainer explicitly requests them.
