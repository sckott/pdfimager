#' pdimg_filter
#' 
#' filter images by their metadata
#' 
#' @export
#' @param x output from [pdimg_images()]
#' @param min_size,max_size a file coerceable by [fs::fs_bytes()]
#' @return same structure as [pdimg_images()]
#' @examples
#' x1 <- system.file("examples/Tierney2017JOSS.pdf", package="pdfimager")
#' x2 <- system.file("examples/vanGemert2018.pdf", package="pdfimager")
#' res <- pdimg_images(c(x1, x2))
#' res
#' res[[1]]$path
#' res[[2]]$path
#' pdimg_filter(x=res)
#' 
#' x4 <- system.file("examples/Wunderlich2020.pdf", package="pdfimager")
#' res <- pdimg_images(x4)
#' pdimg_filter(res, min_size = "100K")
pdimg_filter <- function(x, min_size = NULL, max_size = NULL) {
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
    # minimum image size
    if (!is.null(min_size)) {
      min_size <- fs::fs_bytes(min_size)
      w <- w[fs::fs_bytes(w$size) > min_size, ]
    }
    if (!is.null(max_size)) {
      max_size <- fs::fs_bytes(max_size)
      w <- w[fs::fs_bytes(w$size) < max_size, ]
    }
    return(w)
  })
}
