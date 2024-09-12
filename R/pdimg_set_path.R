#' Set the path to your pdfimages
#' 
#' @export
#' @param path (character) path to pdimages. required
#' @return nothing, `cat()` to console
#' @details `path` is set on an internal (not exported) package environmenzt
#' variable `pdimages_path`
#' 
#' You can also set the path for pdfimages before starting R with an
#' env var like:
#' `PDFIMAGER_PATH=C:/some/path/to/poppler/24/bin/pdfimages.exe R`
#' 
#' Or set within R like:
#' Sys.setenv(PDFIMAGER_PATH="C:/some/path/to/poppler/24/bin/pdfimages.exe")
pdimg_set_path <- function(path = "pdimages") {
  pdimg_env$pdimages_path <- path
}

#' Do you have pdfimages?
#' 
#' @export
#' @return boolean
#' @examplesIf interactive()
#' has_pdfimages()
has_pdfimages <- function() {
  pdfimages_exists()
}
