# analysis/00_download.R
# Fetches the public replication data into data/raw/, skipping any file that
# already exists; nothing here modifies a raw file afterwards. Run from the
# project root:  Rscript analysis/00_download.R
#
# GSE17755: series matrix (normalized log2 ratios against a pooled healthy
#   reference, GPL1291) with the sample characteristics; the raw scanner
#   files (1.1 GB) are not needed.
# GPL1291: the platform table of GSE17755 (probe identifiers to gene symbols).
# GSE326777: neutrophil RNA-seq gene counts and the series matrix (samples).

devtools::load_all(here::here(), quiet = TRUE)
set.seed(20261106)  # no random step; the seed is set as every script does

raw_dir <- here::here("data", "raw")
dir.create(raw_dir, showWarnings = FALSE, recursive = TRUE)
base <- "https://ftp.ncbi.nlm.nih.gov/geo/series"
files <- data.frame(
  accession = c("GSE17755", "GPL1291", "GSE326777", "GSE326777"),
  url = c(
    file.path(base, "GSE17nnn/GSE17755/matrix/GSE17755_series_matrix.txt.gz"),
    paste0("https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GPL1291",
           "&targ=self&form=text&view=data"),
    file.path(base, "GSE326nnn/GSE326777/matrix/GSE326777_series_matrix.txt.gz"),
    file.path(base, "GSE326nnn/GSE326777/suppl/GSE326777_gene_counts_matrix.tsv.gz")
  ),
  stringsAsFactors = FALSE
)
files$file <- file.path(raw_dir, ifelse(files$accession == "GPL1291",
                                        "GPL1291_platform_table.txt",
                                        basename(files$url)))
options(timeout = 600)
files$fetched <- FALSE
for (i in seq_len(nrow(files))) {
  if (file.exists(files$file[i])) next
  # the system curl honours the session's proxy and certificates; retried,
  # since the archive resets connections now and then
  for (attempt in 1:4) {
    ok <- tryCatch({
      utils::download.file(files$url[i], files$file[i], mode = "wb",
                           quiet = TRUE, method = "curl",
                           extra = "--retry 3 --fail")
      TRUE
    }, error = function(e) FALSE)
    if (ok) break
    Sys.sleep(2^attempt)
  }
  stopifnot(ok, file.exists(files$file[i]))
  files$fetched[i] <- TRUE
}
files$bytes <- file.size(files$file)
files$md5 <- unname(tools::md5sum(files$file))
files$file <- basename(files$file)
dir.create(here::here("results"), showWarnings = FALSE)
utils::write.csv(files, here::here("results", "00_download_checksums.csv"),
                 row.names = FALSE)
print(files[, c("file", "bytes", "md5", "fetched")])

dir.create(here::here("results"), showWarnings = FALSE)
saveRDS(list(run = "production", n_rep = NA_integer_, n_cells = NA_integer_,
             date = Sys.time(), n_rep_production = NA_integer_,
             note = "public replication data, GSE17755 and GSE326777"),
        here::here("results", "00_download_run_info.rds"))
writeLines(capture.output(sessionInfo()),
           here::here("results", "00_download_sessionInfo.txt"))
