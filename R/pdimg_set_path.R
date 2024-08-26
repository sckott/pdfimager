#' Set the path to your pdfimages
#' 
#' @export
#' @param path (character) path to pdimages. required
#' @return nothing, `cat()` to console
#' @details `path` is set on an internal (not exported) package environmenzt
#' variable `pdimages_path`
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
