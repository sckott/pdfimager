#' pdimg_meta
#' 
#' extract metadata on images in a pdf
#' 
#' @export
#' @param paths (character) path to a pdf, required
#' @param ... additional params passed on to `pdfimages`. See 
#' [pdimg_help()] for docs
#' @return data.frames of metadata on images in the pdf. if the path is
#' not found or the path is found but no images are found, then a warning
#' is thrown and a zero row data.frame is returned
#' @examples
#' # images found
#' x <- system.file("examples/BachmanEtal2020.pdf", package="pdfimager")
#' pdimg_meta(x)
#' z <- system.file("examples/Tierney2017JOSS.pdf", package="pdfimager")
#' pdimg_meta(z)
#' 
#' # many at once
#' pdimg_meta(c(x, z))
#' 
#' # no images found, but there are actually images 
#' d <- system.file("examples/LahtiEtal2017.pdf", package="pdfimager")
#' pdimg_meta(d)
#' 
#' # no images found, and there really are no images
#' w <- system.file("examples/White2015.pdf", package="pdfimager")
#' pdimg_meta(w)
#' 
#' # path not found
#' pdimg_meta("foo-bar")
#' 
#' # only detects overlayed smaller images on plots, doesn't detect plots
#' g <- system.file("examples/vanGemert2018.pdf", package="pdfimager")
#' pdimg_meta(g)
pdimg_meta <- function(paths, ...) {
  pdfimages_exists()
  lapply(paths, pdimg_meta_one, ...)
}

pdimg_meta_one <- function(path, ...) {
  if (!file.exists(path)) {
    warning("path '", path, "' does not exist", call.=FALSE)
    return(tibble::tibble())
  }
  meta <- sys::exec_internal(
    pdimg_env$pdimages_path, c("-all", "-list", ..., path),
    error = FALSE)
  err_chk(meta)
  txt <- rawToChar(meta$stdout)
  tab <- tryCatch(utils::read.table(text=txt, header=FALSE, skip=2),
    error=function(e) e)
  if (inherits(tab, "error")) {
    msg <- tab$message
    if (grepl("no lines avail", tab$message)) msg <- "no images found in pdf"
    warning(msg, call.=FALSE)
    return(tibble::tibble())
  }
  bits <- strsplit(strsplit(txt, "\n")[[1]][1], "\\s")[[1]]
  nms <- bits[nzchar(bits)]
  # if (NCOL(tab) == length(nms)) names(tab) <- nms
  if (NCOL(tab) != length(nms)) {
    if (is.character(tab$V11))
      tab <- cbind(tab[,1:11], NA, tab[,12:NCOL(tab)])
  }
  names(tab) <- nms
  return(tibble::as_tibble(tab))
}
