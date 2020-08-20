#' pdimg_detect
#' 
#' attempt to detect the "actual" plots in pdfs
#' 
#' @export
#' @param x output from [pdimg_images()]
#' @return xx
#' @examples
#' x1 <- system.file("examples/Tierney2017JOSS.pdf", package="pdfimager")
#' x2 <- system.file("examples/FuHughey2019.pdf", package="pdfimager")
#' x3 <- system.file("examples/vanGemert2018.pdf", package="pdfimager")
#' res <- pdimg_images(c(x1, x2, x3))
#' res
#' res[[1]]$path
#' res[[2]]$path
#' res[[3]]$path
#' pdimg_detect(x=res)
pdimg_detect <- function(x) {
  invisible(lapply(x, assert, y = "tbl"))
  lapply(x, function(w) {
    # drop smask's
    w <- w[w$type != "smask",]
    # remove inline's
    matches <- grep("inline", w$object)
    if (length(matches)) w <- w[-matches,]
    # drop identical images, very likely journal logos
    dups <- table(w$object)
    if (any(dups > 1)) {
      todrop <- names(dups[dups > 1])
      w <- w[!w$object %in% todrop,]
    }
    return(w)
  })
}
