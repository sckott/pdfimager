% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pdimg_meta.R
\name{pdimg_meta}
\alias{pdimg_meta}
\title{pdimg_meta}
\usage{
pdimg_meta(paths, ...)
}
\arguments{
\item{paths}{(character) path to a pdf, required}

\item{...}{additional params passed on to \code{pdfimages}. See
\code{\link[=pdimg_help]{pdimg_help()}} for docs}
}
\value{
data.frames of metadata on images in the pdf. if the path is
not found or the path is found but no images are found, then a warning
is thrown and a zero row data.frame is returned
}
\description{
extract metadata on images in a pdf
}
\examples{
# images found
x <- system.file("examples/BachmanEtal2020.pdf", package="pdfimager")
pdimg_meta(x)
z <- system.file("examples/Tierney2017JOSS.pdf", package="pdfimager")
pdimg_meta(z)

# many at once
pdimg_meta(c(x, z))

# no images found, but there are actually images 
d <- system.file("examples/LahtiEtal2017.pdf", package="pdfimager")
pdimg_meta(d)

# no images found, and there really are no images
w <- system.file("examples/White2015.pdf", package="pdfimager")
pdimg_meta(w)

# path not found
pdimg_meta("foo-bar")

# only detects overlayed smaller images on plots, doesn't detect plots
g <- system.file("examples/vanGemert2018.pdf", package="pdfimager")
pdimg_meta(g)
}
