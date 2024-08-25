pdimg_env <- NULL # nocov start

.onLoad <- function(libname, pkgname){
  pdimg_env <<- new.env()
  pdimg_env$pdimages_path <- "pdfimages"
  path_from_env <- Sys.getenv("PDFIMAGER_PATH")
  if (path_from_env != "") {
    pdimg_env$pdimages_path <- path_from_env
  }
} # nocov end
