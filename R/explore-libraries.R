#' ---
#' output: github_document
#' ---


#' Which libraries does R search for packages?

# try .libPaths(), .Library
.libPaths()
.Library

#' Installed packages

## use installed.packages() to get all installed packages
## if you like working with data frame or tibble, make it so right away!
## remember to use View(), dplyr::glimpse(), or similar to inspect

pckg_list <- tibble::tibble(installed.packages())

pckg_list <- tibble::as_tibble(installed.packages())

##??why does tibble give me a 161x1, but as_tibble give me 161x16???


## how many packages?
dplyr::glimpse(pckg_list)
###161 packages

#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
##   * what proportion need compilation?
##   * how break down re: version of R they were built on

pckg_list %>% 
  dplyr::group_by(Version) %>% 
  dplyr::summarise(count = dplyr::n()) %>% 
  dplyr::arrange(desc(Version))

pckg_list %>% 
  dplyr::group_by(NeedsCompilation) %>% 
  dplyr::summarise(count = dplyr::n()) %>% 
  dplyr::arrange(desc(count))

pckg_list %>% 
  dplyr::count(LibPath, Priority)

pckg_list %>% 
  dplyr::count(NeedsCompilation) %>% 
  dplyr::mutate(prop = n / sum(n))

pckg_list %>% 
  dplyr::count(Built) %>% 
  dplyr::mutate(prop = n / sum(n))

## for tidyverts, here are some useful patterns
# data %>% count(var)
# data %>% count(var1, var2)
# data %>% count(var) %>% mutate(prop = n / sum(n))

#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?


#' Going further

## if you have time to do more ...

## is every package in .Library either base or recommended?
## study package naming style (all lower case, contains '.', etc)
## use `fields` argument to installed.packages() to get more info and use it!
