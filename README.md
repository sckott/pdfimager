pdfimager
=========



[![R-check](https://github.com/sckott/pdfimager/workflows/R-check/badge.svg)](https://github.com/sckott/pdfimager/actions/)


`pdfimager` - Extract images from pdfs

This packages uses `sys` R package to "shell out" to pdfimages. Apparently pdfimages is not in poppler cpp, so is not in pdftools R pkg

## Install pdfimages

pdfimages is installed when you install poppler

Installation instructions can be found at <https://poppler.freedesktop.org/>

## Install pdfimager


```r
remotes::install_github("sckott/pdfimager")
```


```r
library("pdfimager")
```

## help info


```r
pdimg_help()
#> pdfimages version 0.90.1
#> Copyright 2005-2020 The Poppler Developers - http://poppler.freedesktop.org
#> Copyright 1996-2011 Glyph & Cog, LLC
#> Usage: pdfimages [options] <PDF-file> <image-root>
#>   -f <int>       : first page to convert
#>   -l <int>       : last page to convert
#>   -png           : change the default output format to PNG
#>   -tiff          : change the default output format to TIFF
#>   -j             : write JPEG images as JPEG files
#>   -jp2           : write JPEG2000 images as JP2 files
#>   -jbig2         : write JBIG2 images as JBIG2 files
#>   -ccitt         : write CCITT images as CCITT files
#>   -all           : equivalent to -png -tiff -j -jp2 -jbig2 -ccitt
#>   -list          : print list of images instead of saving
#>   -opw <string>  : owner password (for encrypted files)
#>   -upw <string>  : user password (for encrypted files)
#>   -p             : include page numbers in output file names
#>   -q             : don't print any messages or errors
#>   -v             : print copyright and version info
#>   -h             : print usage information
#>   -help          : print usage information
#>   --help         : print usage information
#>   -?             : print usage information
```

## pdf image metadata


```r
x <- system.file("examples/BachmanEtal2020.pdf", package="pdfimager")
pdimg_meta(x)
#> [[1]]
#> # A tibble: 3 x 16
#>    page   num type  width height color  comp   bpc enc   interp object    ID
#>   <int> <int> <chr> <int>  <int> <chr> <int> <int> <chr> <chr>   <int> <int>
#> 1     5     0 image  1024    573 rgb       3     8 jpeg  yes       178     0
#> 2     8     1 image  1024   1001 rgb       3     8 jpeg  yes       146     0
#> 3    11     2 image  1024    988 rgb       3     8 jpeg  yes       110     0
#> # … with 4 more variables: `x-ppi` <int>, `y-ppi` <int>, size <chr>,
#> #   ratio <chr>
```

## pdf images


```r
x <- system.file("examples/BachmanEtal2020.pdf", package="pdfimager")
pdimg_images(x)
#> [[1]]
#> # A tibble: 3 x 17
#>   path   page   num type  width height color  comp   bpc enc   interp object
#>   <chr> <int> <int> <chr> <int>  <int> <chr> <int> <int> <chr> <chr>   <int>
#> 1 /var…     5     0 image  1024    573 rgb       3     8 jpeg  yes       178
#> 2 /var…     8     1 image  1024   1001 rgb       3     8 jpeg  yes       146
#> 3 /var…    11     2 image  1024    988 rgb       3     8 jpeg  yes       110
#> # … with 5 more variables: ID <int>, x.ppi <int>, y.ppi <int>, size <chr>,
#> #   ratio <chr>
```

## Meta

* Please [report any issues or bugs](https://github.com/sckott/pdfimager/issues)
* License: MIT
* Please note that the namext project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
