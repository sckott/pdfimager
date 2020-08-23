#' pdimg_images
#' 
#' extract images from a pdf
#' 
#' @export
#' @param paths (character) path to a pdf, required
#' @param base_dir (character) the base path to collect files into. if `NULL`
#' (default), we use a temp directory
#' @param ... additional params passed on to `pdfimages`. See 
#' [pdimg_help()] for docs
#' @return data.frames of metadata on images in the pdf. if the path is
#' not found or the path is found but no images are found, then a warning
#' is thrown and a zero row data.frame is returned
#' @note by default we use temp dir to store extracted images - at the end
#' of an R session these are cleaned up (deleted). to store images 
#' after the R session ends use `base_dir`
#' @examples
#' # images found
#' x <- system.file("examples/BachmanEtal2020.pdf", package="pdfimager")
#' res <- pdimg_images(x)
#' res
#' res[[1]]$path
#' file.exists(res[[1]]$path[1])
#' 
#' z <- system.file("examples/Tierney2017JOSS.pdf", package="pdfimager")
#' pdimg_images(z)
#' 
#' # many at once
#' pdimg_images(c(x, z))
#' ## pass custom dir to each path
#' pdimg_images(c(x, z), file.path(tempdir(), "pepperjackcheese"))
#' 
#' # no images found, but there are actually images 
#' d <- system.file("examples/LahtiEtal2017.pdf", package="pdfimager")
#' pdimg_images(d)
#' 
#' # no images found, and there really are no images
#' w <- system.file("examples/White2015.pdf", package="pdfimager")
#' pdimg_images(w)
#' 
#' # path not found
#' pdimg_images("foo-bar")
#' 
#' # only gets overlayed smaller images on plots, doesn't get plots
#' # themselves
#' g <- system.file("examples/vanGemert2018.pdf", package="pdfimager")
#' pdimg_images(g)
#' 
#' # number of images doesn't match number of rows of metadata
#' ## so we fix internally by removing duplicate files for same image
#' g <- system.file("examples/SanyalEtal2018.pdf", package="pdfimager")
#' pdimg_images(g)
pdimg_images <- function(paths, base_dir = NULL, ...) {
  pdfimages_exists()
  if (!is.null(base_dir)) {
    assert(base_dir, "character")
    stopifnot(length(base_dir) == 1)
  }
  lapply(paths, pdimg_image, dir = base_dir, ...)
}

pdimg_image <- function(path, dir = NULL, ...) {
  if (!file.exists(path)) {
    warning("path '", path, "' does not exist", call.=FALSE)
    return(tibble::tibble())
  }
  if (is.null(dir)) {
    dir <- file.path(tempdir(), gsub(".pdf", "", basename(path)), "img")
  } else {
    dir <- file.path(dir, gsub(".pdf", "", basename(path)), "img")
  }
  dir.create(dirname(dir), recursive = TRUE, showWarnings = FALSE)
  res <- sys::exec_internal("pdfimages", c("-all", ..., path, dir),
    error = FALSE)
  err_chk(res)
  if (res$status != 0) {
    warning(rawToChar(res$stderr), call.=FALSE)
    return(tibble::tibble())
  }
  df <- pdimg_meta(path)[[1]]
  ff <- list.files(dirname(dir), full.names=TRUE)
  if (length(ff) > NROW(df)) {
    # definitely a hack: just remove any duplicated files for the same image
    strs <- vapply(ff, function(z) strsplit(basename(z), "\\.")[[1]][1], "")
    if (any(duplicated(strs))) {
      ff <- ff[!duplicated(strs)]
    }
  }
  if (length(ff) > 0) df <- data.frame(path = ff, df)
  return(tibble::as_tibble(df))
}
