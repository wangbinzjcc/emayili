#' Title
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
  #
  # content <- knitr::knit2html(input=rmd_filepath, options=c("use_xhtml","smartypants","mathjax","highlight_code"))
  # content = readLines(output_path) %>% paste(collapse = "\n")
  # print(substr(content, 1, 500))

  # content <- readChar(output_path, file.info(output_path)$size)
  # print(content)
  #
  # type <- "text/html"
  # #
  # body <- mime(type, "quoted-printable", NULL, "utf-8")
  # body$body <- content
  #
  # msg$parts <- c(msg$parts, list(body))

  msg <- msg %>% attachment(output_path)

  invisible(msg)
}
