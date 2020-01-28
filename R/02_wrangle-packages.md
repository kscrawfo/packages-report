02\_wrangle-packages.R
================
KyleCrawford
2020-01-27

``` r
## remember to restart R here!

## create a data frame by reading from data/installed-packages.csv
## hint: readr::read_csv() or read.csv()
## idea: try using here::here() to create the file path

dat <- readr::read_csv(here::here("data", "installed-packages.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   Package = col_character(),
    ##   LibPath = col_character(),
    ##   Version = col_character(),
    ##   Priority = col_character(),
    ##   Depends = col_character(),
    ##   Imports = col_character(),
    ##   LinkingTo = col_character(),
    ##   Suggests = col_character(),
    ##   Enhances = col_character(),
    ##   License = col_character(),
    ##   License_is_FOSS = col_character(),
    ##   License_restricts_use = col_logical(),
    ##   OS_type = col_logical(),
    ##   MD5sum = col_logical(),
    ##   NeedsCompilation = col_character(),
    ##   Built = col_character()
    ## )

``` r
## filter out the base and recommended packages
## keep the variables Package and Built
## if you use dplyr, code like this will work:
# apt <- ipt %>%
#   filter(is.na(Priority)) %>%
#   select(Package, Built)

dat2 <- dat %>%
  dplyr::filter(is.na(Priority)) %>%
  dplyr::select(Package, Built)

## write this new, smaller data frame to data/add-on-packages.csv
## hint: readr::write_csv() or write.table()
## idea: try using here::here() to create the file path
readr::write_csv(dat2, here::here("data", "add-on-packages.csv"))

## make a frequency table of package by the version in Built
## if you use dplyr, code like this will work:
# apt_freqtable <- apt %>%
#   count(Built) %>%
#   mutate(prop = n / sum(n))

dat2_freq <- dat2 %>%
  dplyr::count(Built) %>%
  dplyr::mutate(prop = n / sum(n))

## write this data frame to data/add-on-packages-freqtable.csv
## hint: readr::write_csv() or write.table()
## idea: try using here::here() to create the file path
readr::write_csv(dat2_freq, here::here("data", "add-on-packages-freqtable.csv"))

## YES overwrite the files that are there now
## they are old output from me (Jenny)
## they are just examples
```
