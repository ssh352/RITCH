
#' Returns a data.table of the sample files on the FTP server
#'
#' @return a data.table of the files
#' @export
#'
#' @examples
#' \dontrun{
#' list_sample_files()
#' }
list_sample_files <- function() {
  
  url <- "ftp://emi.nasdaq.com/ITCH/"
  raw <- readLines(url)
  
  cont <- unlist(strsplit(raw, "\n"))
  cont <- cont[grepl("ITCH_?50\\.gz$", cont)]
  cont <- strsplit(cont, " +")
  
  df <- data.table::data.table(
    file = sapply(cont, function(x) x[4]),
    size = sapply(cont, function(x) x[3]),
    date = sapply(cont, function(x) x[1]),
    time = sapply(cont, function(x) x[2])
  )
  
  df[, ':=' (
    file_size = as.numeric(size),
    last_modified = as.POSIXct(paste(date, time), format = "%m-%d-%y %H:%M%p", tz = "GMT"),
    exchange = get_exchange_from_filename(file),
    date = get_date_from_filename(file)
  )]
  
  return(df[, .(file, exchange, date, file_size, last_modified)])
  
}
#' Downloads a sample ITCH File from NASDAQs FTP Server
#' 
#' The FTP Server can be found at \url{ftp://emi.nasdaq.com/ITCH/}
#' 
#' Warning: the smallest file is around 300 MB, with the largest exceeding 5 GB. 
#' There are about 17 files in total. Downloading all might take a considerable amount of time.
#'
#' @param choice which file should be chosen? One of: smallest (default), largest, 
#' earliest (date-wise), latest, random, or all.
#' @param exchanges A vector of exchanges, can be NASDAQ, BX, or PSX. 
#' The default value is to consider all exchanges.
#' @param dir The directory where the files will be saved to, default is current working directory.
#' @param force_download If the file should be downloaded even if it already exists locally. 
#' Default value is FALSE.
#' @param check_md5sum If the md5-sum (hash-value) of the downloaded file should be checked, default value is TRUE.
#' @param verbose If the function should be verbose, default value is TRUE.
#'
#' @return an invisible vector of the files
#' @export
#'
#' @examples
#' \dontrun{
#' download_sample_file()
#' file <- download_sample_file()
#' file
#' 
#' }
download_sample_file <- function(choice = c("smallest", "largest", "earliest", "latest",  "random", "all"),
                                 exchanges = NA,
                                 dir = ".",
                                 force_download = FALSE,
                                 check_md5sum = TRUE,
                                 verbose = TRUE) {
  choice <- match.arg(choice)
  
  url <- "ftp://emi.nasdaq.com/ITCH/"
  df <- list_sample_files()
  
  if (length(exchanges) != 1 && !is.na(exchanges)) 
    df <- df[exchange %in% toupper(exchanges), ]
  
  if (verbose) cat(paste0("Downloading '", choice, "' sample file(s)\n"))
  
  if (choice %in% c("smallest", "largest")) df <- df[order(file_size, decreasing = TRUE)]
  if (choice %in% c("earliest", "latest")) df <- df[order(date, decreasing = TRUE)]
  
  idx <- switch(choice,
                smallest = nrow(df),
                random = sample.int(nrow(df), 1),
                largest = 1,
                earliest = nrow(df),
                latest = 1,
                all = 1:nrow(df))
  
  df_take <- df[idx, ]
  
  files <- apply(df_take, 1, function(el) {
    file <- el[["file"]]
    file_path <- file.path(dir, file)
    
    download_file <- TRUE
    
    if (file.exists(file_path)) {
      txt <- paste0("File '", file_path, "' exists already, ")
      
      if (force_download) {
        if (verbose) cat(paste0(txt, "downloading!\n"))
      } else {
        if (verbose) cat(paste0(txt, "not downloading it again!\n"))
        download_file <- FALSE
      }
    }
    file_url <- paste0(url, file)
    
    
    if (download_file) {
      if (verbose) cat(paste0("Downloading File '", file_path, "'.\n"))
      download.file(file_url, destfile = file_path, mode = "wb", quiet = !verbose)
    }
    
    if (check_md5sum) {
      if (verbose) cat(paste0("Checking md5 sum of file '", file_path, "' ... "))
      md5_url <- paste0(file_url, ".md5sum")
      md5 <- readLines(md5_url)
      expected <- strsplit(md5, " ")[[1]][1]
      got <- tools::md5sum(file_path)
      if (expected != got) {
        if (verbose) cat("\n")
        warning(paste0("md5 hash for file '", file_path,
                       "' not matching.\nExpected '", expected, "' got '", got, "'!"))
      } else {
        if (verbose) cat(paste0("matches '", expected, "' - success !\n"))
      }
    }
    
    return(file)
  })
  
  return(invisible(files))
}
