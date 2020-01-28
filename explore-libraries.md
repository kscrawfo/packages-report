explore-libraries.R
================
KyleCrawford
2020-01-27

Which libraries does R search for packages?

``` r
# try .libPaths(), .Library
.libPaths()
```

    ## [1] "C:/Users/KyleCrawford/Documents/R/win-library/3.6"
    ## [2] "C:/Program Files/R/R-3.6.1/library"

``` r
.Library
```

    ## [1] "C:/PROGRA~1/R/R-36~1.1/library"

Installed packages

``` r
## use installed.packages() to get all installed packages
## if you like working with data frame or tibble, make it so right away!
## remember to use View(), dplyr::glimpse(), or similar to inspect

pckg_list <- tibble::tibble(installed.packages())

pckg_list <- tibble::as_tibble(installed.packages())

##??why does tibble give me a 161x1, but as_tibble give me 161x16???


## how many packages?
dplyr::glimpse(pckg_list)
```

    ## Observations: 161
    ## Variables: 16
    ## $ Package               <chr> "askpass", "assertthat", "babynames", "b...
    ## $ LibPath               <chr> "C:/Users/KyleCrawford/Documents/R/win-l...
    ## $ Version               <chr> "1.1", "0.2.1", "1.0.0", "1.1.4", "0.1-3...
    ## $ Priority              <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ Depends               <chr> NA, NA, "R (>= 2.10)", "R (>= 3.0.0)", "...
    ## $ Imports               <chr> "sys (>= 2.1)", "tools", "tibble", "util...
    ## $ LinkingTo             <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ Suggests              <chr> "testthat", "testthat, covr", "testthat ...
    ## $ Enhances              <chr> NA, NA, NA, NA, "png", NA, NA, NA, NA, N...
    ## $ License               <chr> "MIT + file LICENSE", "GPL-3", "CC0", "G...
    ## $ License_is_FOSS       <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ License_restricts_use <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ OS_type               <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ MD5sum                <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ NeedsCompilation      <chr> "yes", "no", "no", "yes", "yes", "no", "...
    ## $ Built                 <chr> "3.6.1", "3.6.1", "3.6.2", "3.6.0", "3.6...

``` r
###161 packages
```

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
##   * what proportion need compilation?
##   * how break down re: version of R they were built on

pckg_list %>% 
  dplyr::group_by(Version) %>% 
  dplyr::summarise(count = dplyr::n()) %>% 
  dplyr::arrange(desc(Version))
```

    ## # A tibble: 108 x 2
    ##    Version  count
    ##    <chr>    <int>
    ##  1 7.3-51.4     1
    ##  2 7.3-15       1
    ##  3 7.3-12       1
    ##  4 7.3-11       1
    ##  5 7.0.2        1
    ##  6 7.0-1        1
    ##  7 4.1-15       1
    ##  8 4.0          1
    ##  9 3.6.1       15
    ## 10 3.4.1        1
    ## # ... with 98 more rows

``` r
pckg_list %>% 
  dplyr::group_by(NeedsCompilation) %>% 
  dplyr::summarise(count = dplyr::n()) %>% 
  dplyr::arrange(desc(count))
```

    ## # A tibble: 3 x 2
    ##   NeedsCompilation count
    ##   <chr>            <int>
    ## 1 no                  79
    ## 2 yes                 76
    ## 3 <NA>                 6

``` r
pckg_list %>% 
  dplyr::count(LibPath, Priority)
```

    ## # A tibble: 4 x 3
    ##   LibPath                                           Priority        n
    ##   <chr>                                             <chr>       <int>
    ## 1 C:/Program Files/R/R-3.6.1/library                base           14
    ## 2 C:/Program Files/R/R-3.6.1/library                recommended    15
    ## 3 C:/Program Files/R/R-3.6.1/library                <NA>            1
    ## 4 C:/Users/KyleCrawford/Documents/R/win-library/3.6 <NA>          131

``` r
pckg_list %>% 
  dplyr::count(NeedsCompilation) %>% 
  dplyr::mutate(prop = n / sum(n))
```

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n   prop
    ##   <chr>            <int>  <dbl>
    ## 1 no                  79 0.491 
    ## 2 yes                 76 0.472 
    ## 3 <NA>                 6 0.0373

``` r
pckg_list %>% 
  dplyr::count(Built) %>% 
  dplyr::mutate(prop = n / sum(n))
```

    ## # A tibble: 3 x 3
    ##   Built     n   prop
    ##   <chr> <int>  <dbl>
    ## 1 3.6.0    12 0.0745
    ## 2 3.6.1   108 0.671 
    ## 3 3.6.2    41 0.255

``` r
## for tidyverts, here are some useful patterns
# data %>% count(var)
# data %>% count(var1, var2)
# data %>% count(var) %>% mutate(prop = n / sum(n))
```

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
```

Going further

``` r
## if you have time to do more ...

## is every package in .Library either base or recommended?
## study package naming style (all lower case, contains '.', etc)
## use `fields` argument to installed.packages() to get more info and use it!
```
