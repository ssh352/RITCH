#' Retrieves the messages of an ITCH-file
#'
#' If the file is too large to be loaded into the file at once,
#' you can specify different start_msg_count/end_msg_counts to load only some messages.
#' 
#' @param file the path to the input file, either a gz-file or a plain-text file
#' @param buffer_size the size of the buffer in bytes, defaults to 1e8 (100 MB), 
#' if you have a large amount of RAM, 1e9 (1GB) might be faster 
#' @param start_msg_count the start count of the messages, defaults to 0, or a data.frame of msg_types and counts, as outputted by count_messages()
#' @param end_msg_count the end count of the messages, defaults to all messages
#' @param quiet if TRUE, the status messages are supressed, defaults to FALSE
#' @param force_gunzip only applies if file is a gz-file and a file with the same (gunzipped) name already exists.
#'        if set to TRUE, the existing file is overwritten. Default value is FALSE
#' @param force_cleanup only applies if file is a gz-file. If force_cleanup=TRUE, the gunzipped raw file will be deleted afterwards.
#'
#' @return a data.table containing the orders
#' @export
#'
#' @examples
#' \dontrun{
#'   raw_file <- "20170130.PSX_ITCH_50"
#'   get_orders(raw_file)
#'   get_orders(raw_file, quiet = TRUE)
#' 
#'   # load only the message 20, 21, 22 (index starts at 1)
#'   get_orders(raw_file, startMsgCount = 20, endMsgCount = 22)
#' }
#' 
#' \dontrun{
#'   gz_file <- "20170130.PSX_ITCH_50.gz"
#'   get_orders(gz_file)
#'   get_orders(gz_file, quiet = TRUE)
#'   
#'   msg_count <- count_messages(raw_file)
#'   get_orders(raw_file, msg_count)
#' }
get_orders <- function(file, start_msg_count = 0, end_msg_count = -1, 
                       buffer_size = -1, quiet = FALSE,
                       force_gunzip = FALSE, force_cleanup = FALSE) {
  t0 <- Sys.time()
  if (!file.exists(file)) stop("File not found!")

  # Set the default value of the buffer size
  if (buffer_size < 0)
    buffer_size <- ifelse(grepl("\\.gz$", file), 
                          min(3 * file.size(file), 1e9), 
                          1e8)
  
  if (buffer_size < 50) stop("buffer_size has to be at least 50 bytes, otherwise the messages won't fit")
  if (buffer_size > 5e9) warning("You are trying to allocate a large array on the heap, if the function crashes, try to use a smaller buffer_size")
  
  date_ <- get_date_from_filename(file)
  
  if (is.data.frame(start_msg_count)) {
    if (!all(c("msg_type", "count") %in% names(start_msg_count))) 
      stop("If start_msg_count is a data.frame/table, it must contain 'msg_type' and 'count'!")
    dd <- start_msg_count
    start_msg_count <- 1
    msg_types <- c("A", "F")
    end_msg_count <- as.integer(dd[msg_type %in% msg_types, sum(count)])
  }
  
  orig_file <- file
  file <- check_and_gunzip(file, buffer_size, force_gunzip, quiet)
  
  # -1 because we want it 1 indexed (cpp is 0-indexed) 
  # and max(0, xxx) b.c. the variable is unsigned!
  df <- getOrders_impl(file, max(start_msg_count - 1, 0),
                       max(end_msg_count - 1, -1), buffer_size, quiet)
  
  # if the file was gzipped and the force_cleanup=TRUE, delete unzipped file 
  if (grepl("\\.gz$", orig_file) && force_cleanup) unlink(gsub("\\.gz", "", file))
  
  if (!quiet) cat("\n[Converting] to data.table\n")
  
  df <- data.table::setalloccol(df)
  
  # add the date
  df[, date := date_]
  df[, datetime := nanotime(as.Date(date_)) + timestamp]
  
  df[, exchange := get_exchange_from_filename(file)]

  a <- gc()
  
  diff_secs <- as.numeric(difftime(Sys.time(), t0, units = "secs"))
  if (!quiet) cat(sprintf("[Done]       in %.2f secs\n", diff_secs))
  
  return(df[])
}
