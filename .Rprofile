source("renv/activate.R")

# Point reticulate at the project's Python environment, managed by uv
# (.venv/, created by `uv sync`), when it exists. R-only projects are not
# affected.
local({
  py <- file.path(getwd(), ".venv",
                  if (.Platform$OS.type == "windows") "Scripts/python.exe"
                  else "bin/python")
  if (file.exists(py)) Sys.setenv(RETICULATE_PYTHON = py)
})
