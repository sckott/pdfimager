% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pdimg_images.R
\name{pdimg_images}
\alias{pdimg_images}
\title{pdimg_images}
\usage{
pdimg_images(paths, base_dir = NULL, ...)
}
\arguments{
\item{paths}{(character) path to a pdf, required}

\item{base_dir}{(character) the base path to collect files into. if \code{NULL}
(default), we use a temp directory}

\item{...}{additional command line args passed on to \code{pdfimages}. See
\code{\link[=pdimg_help]{pdimg_help()}} for docs}
}
\value{
data.frames of metadata on images in the pdf. if the path is
not found or the path is found but no images are found, then a warning
is thrown and a zero row data.frame is returned
}
\description{
extract images from a pdf
}
\note{
by default we use temp dir to store extracted images - at the end
of an R session these are cleaned up (deleted). to store images
after the R session ends use \code{base_dir}
}
\examples{
# images found
x <- system.file("examples/BachmanEtal2020.pdf", package="pdfimager")
res <- pdimg_images(x)
res
res[[1]]$path
file.exists(res[[1]]$path[1])

z <- system.file("examples/Tierney2017JOSS.pdf", package="pdfimager")
pdimg_images(z)

# change base directory to hold extracted images
x <- system.file("examples/BachmanEtal2020.pdf", package="pdfimager")
dir <- file.path(tempdir(), "bluetree")
res <- pdimg_images(x, base_dir = dir)

# many at once
pdimg_images(c(x, z))
## pass custom dir to each path
pdimg_images(c(x, z), file.path(tempdir(), "pepperjackcheese"))

# no images found, but there are actually images 
d <- system.file("examples/LahtiEtal2017.pdf", package="pdfimager")
pdimg_images(d)

# no images found, and there really are no images
w <- system.file("examples/White2015.pdf", package="pdfimager")
pdimg_images(w)

# path not found
pdimg_images("foo-bar")

# only gets overlayed smaller images on plots, doesn't get plots
# themselves
g <- system.file("examples/vanGemert2018.pdf", package="pdfimager")
pdimg_images(g)

# number of images doesn't match number of rows of metadata
## so we fix internally by removing duplicate files for same image
h <- system.file("examples/SanyalEtal2018.pdf", package="pdfimager")
pdimg_images(h)

# convert to another format - not entirely sure how this works,
# it's not documented
j <- system.file("examples/SanyalEtal2018.pdf", package="pdfimager")
pdimg_images(j, format = "-png")[[1]]$path[1:5]
}
