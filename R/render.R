#' Render R Markdown document into email
#'
#' @param msg A message object.
#' @param rmd_filepath Path to a Rmd file.
#' @param quiet Suppress output.
#'
#' @return
#' @export
#'
#' @examples
render <- function(msg, rmd_filepath, quiet = TRUE){
  output_path = tempfile(fileext = ".html")
  #
  rmarkdown::render(rmd_filepath, output_file = output_path, quiet = quiet)

  # OPTION 1
  #
  # msg <- msg %>% attachment(output_path)

  # OPTION 2
  #
  content <- readChar(output_path, file.info(output_path)$size)
  content <- sub("^<!DOCTYPE html>\n", "", content)
  msg <- msg %>% body(content, type = "html")

  print(output_path)

  invisible(msg)
}
