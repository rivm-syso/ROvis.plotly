<!-- badges: start -->
[![CI](https://img.shields.io/endpoint?url=https://rivm-syso.github.io/ROvis.plotly/badges/ci.json)](https://github.com/rivm-syso/ROvis.plotly/actions/workflows/ci.yaml)
[![Lint](https://img.shields.io/endpoint?url=https://rivm-syso.github.io/ROvis.plotly/badges/lint.json)](https://github.com/rivm-syso/ROvis.plotly/actions/workflows/ci.yaml)
[![Coverage](https://img.shields.io/endpoint?url=https://rivm-syso.github.io/ROvis.plotly/badges/coverage.json)](https://github.com/rivm-syso/ROvis.plotly/actions/workflows/ci.yaml)
<!-- badges: end -->


# ROvis.plotly <a href="https://github.com/rivm-syso/ROvis.plotly"><img src="man/figures/logo.png" align="right" height="138" /></a>

## Rijksoverheid Visualisatie - plotly

## Description
A tool to uniformly visualise interactive graphs in 'plotly' using standardized Rijksoverheid (Dutch National Government) styling. This package is part of the [ROvis umbrella package] (https://github.com/rivm-syso/ROvis).

## Installation

```r
# Install from GitHub (private repo - requires GitHub auth, e.g. a PAT
# via usethis::create_github_token() / gitcreds, since this repo is private)
# install.packages("remotes")
remotes::install_github("rivm-syso/ROvis.plotly")
```


## Usage

A short example of on how to use the ro_ply_add_theme() function in combination with your plotly-object.
For the full functionality, please see the vignettes.

```r
bar_data <- tibble::tibble(
  Sex = c("Man", "Vrouw"),
  n = c(1234, 1675)
)

# Use the  color function for Rijksoverheid / RIVM colors
sex_colors <- c(
  "Man" = ro_color("hemelblauw"),
  "Vrouw" = ro_color("robijnrood")
)

# Create plotly bar chart
fig <- plot_ly(
  data = bar_data,
  x = ~Sex,
  y = ~n,
  type = "bar",
  color = ~Sex,
  colors = sex_colors,
  text = ~paste0(
    "Geslacht: <b>", Sex, "</b>",
    "<br>Aantal cases: <b>", 
    format(round(n, 0), big.mark = ".", decimal.mark = ",", scientific = FALSE), "</b>"
  ),
  hoverinfo = "text"
)

# Apply Rijksoverheid / RIVM theme
fig <- ro_ply_add_theme(fig, ro_ply_theme())
```

## Support
First point of contact for questions: spin@rivm.nl (spin@rivm.nl)


## Contributing
We welcome contributions and are always happy to see people help improve this package.
If you would like to contribute, please first open an issue to describe the bug, feature, or proposed change. Once you are ready, submit a pull request linked to that issue.
All contributions will be reviewed by the SPIN team before they are merged.

## Instructions for developers 

For information about R package development, check the [R Packages book](https://r-pkgs.org/). 
Below we describe the most important guidelines and practicalities.


### Requirements
We use the `testthat`, `lintr` and `roxygen2` package for development of tests, code style 
checks and automatic documentation. We also use the `devtools` and `usethis` package during 
development to adhere to standards for R packages and make developing easier! Install them 
in your Rstudio environment:

```r
install.packages(testthat)
install.packages(lintr)
install.packages(roxygen2)
install.packages(quarto)
install.packages(pkgdown)
install.packages(devtools)
install.packages(usethis)
```

### Guidelines
Type `devtools::load_all()` in your console each time you start developing. This loads 
all dependencies and non-exported functions in the NAMESPACE. This makes developing a lot easier!

To ensure code standardization and quality, follow these guidelines:
- Add tests with `usethis::use_test()`
- Add a new package dependency to the DESCRIPTION file with `usethis::use_package()`. We use 
the `min_version` argument to specify a minimum version. 
- Add a new function dependency to the NAMESPACE with `usethis::use_import_from()`
- Add documentation to new functions by inserting a roxygen skeleton and use `devtools::document()` to
create automatic documentation in the `man` folder

## Authors and acknowledgment
This R package was created by ROvis team (spin@rivm.nl).

## License
This package uses an Apache license.
