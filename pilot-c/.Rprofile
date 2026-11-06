# Activates the project's renv library when R starts in manuscript/, for
# example when Quarto renders manuscript.qmd from this directory. The
# project root's .Rprofile does the same when R starts there. R reads only
# the .Rprofile of the directory it starts in, so both files are needed.
local({
  root <- normalizePath(file.path(getwd(), ".."), mustWork = TRUE)
  Sys.setenv(RENV_PROJECT = root)
  source(file.path(root, "renv", "activate.R"))
  # And reticulate at the project's uv-managed Python environment, if any.
  py <- file.path(root, ".venv",
                  if (.Platform$OS.type == "windows") "Scripts/python.exe"
                  else "bin/python")
  if (file.exists(py)) Sys.setenv(RETICULATE_PYTHON = py)
})
