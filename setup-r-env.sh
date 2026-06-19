#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_ROOT"

PACKAGES=()
if [[ $# -gt 0 ]]; then
  if [[ "${1:-}" == "--packages" || "${1:-}" == "-p" ]]; then
    shift
  fi

  for arg in "$@"; do
    IFS=',' read -r -a parts <<< "$arg"
    for package in "${parts[@]}"; do
      package="${package//[[:space:]]/}"
      if [[ -n "$package" ]]; then
        PACKAGES+=("$package")
      fi
    done
  done
fi

echo "Project: $PROJECT_ROOT"

if ! command -v Rscript >/dev/null 2>&1; then
  echo "Rscript was not found on PATH. Install R first, then restart your terminal/VS Code." >&2
  exit 1
fi

SETUP_R_PACKAGES="$(IFS=';'; echo "${PACKAGES[*]:-}")"
export SETUP_R_PACKAGES

TEMP_SCRIPT="$(mktemp "${TMPDIR:-/tmp}/setup-renv-XXXXXX.R")"
cleanup() {
  rm -f "$TEMP_SCRIPT"
}
trap cleanup EXIT

cat > "$TEMP_SCRIPT" <<'RSCRIPT'
project <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
packages <- strsplit(Sys.getenv("SETUP_R_PACKAGES", ""), ";", fixed = TRUE)[[1]]
packages <- packages[nzchar(packages)]

repos <- getOption("repos")
if (is.null(repos) || identical(unname(repos["CRAN"]), "@CRAN@")) {
  options(repos = c(CRAN = "https://cloud.r-project.org"))
}

if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

if (!file.exists(file.path(project, "renv", "activate.R"))) {
  renv::init(project = project, bare = TRUE, restart = FALSE)
} else {
  renv::load(project = project)
}

if (file.exists(file.path(project, "renv.lock"))) {
  renv::restore(project = project, prompt = FALSE)
}

deps <- renv::dependencies(path = project, root = project, progress = FALSE)
deps <- unique(deps$Package)
deps <- deps[!deps %in% c("R", "renv")]
to_install <- unique(c(deps, packages))

if (length(to_install) > 0) {
  renv::install(to_install, project = project)
}

renv::snapshot(project = project, prompt = FALSE)

vscode_dir <- file.path(project, ".vscode")
dir.create(vscode_dir, showWarnings = FALSE)

settings_path <- file.path(vscode_dir, "settings.json")
settings <- '{
  "r.rterm.windows": "R.exe",
  "r.rterm.linux": "R",
  "r.rterm.mac": "R",
  "r.alwaysUseActiveTerminal": true,
  "r.bracketedPaste": true,
  "r.sessionWatcher": true
}
'
writeLines(settings, settings_path, useBytes = TRUE)

cat("\nR project environment is ready.\n")
cat("Open this folder in VS Code, then run R from the project root.\n")
RSCRIPT

Rscript "$TEMP_SCRIPT"

echo ""
echo "Done. Useful commands:"
echo "  bash setup-r-env.sh"
echo "  bash setup-r-env.sh ggplot2 dplyr readr"
echo "  bash setup-r-env.sh --packages ggplot2,dplyr,readr"
echo "  Rscript homework_1.R"
