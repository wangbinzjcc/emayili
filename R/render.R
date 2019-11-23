# MD2HTML <- function (markdown, workingDirectory = NULL, environment = NULL) {
#   SetKnitrOptions(workingDirectory)
#   if (is.null(environment)) environment <- parent.frame()
#   html <- knitr::knit2html(text=markdown, options=c("use_xhtml", "smartypants", "mathjax", "highlight_code"), stylesheet = GetMarkDownCss(), envir = environment)
#
#   return(html)
# }
#
# RMD2HTML <- function (sourceFilePath, outputFilePath = NULL, environment = NULL) {
#   markdown <- ReadFile(sourceFilePath)
#   html <- MD2HTML(markdown, workingDirectory = sourceFilePath, environment)
#
#   # Strip "<!DOCTYPE html>" from top of HTML document (doesn't parse properly in mail).
#   #
#   html <- sub("^<!DOCTYPE html>\n", "", html)
#
#   if (!is.null(outputFilePath)) {
#     WriteFile(text = html, fileName = outputFilePath)
#   }
#
#   return(html)
# }
#
# #Functions to encode images inline (base64)
#
# MD2HTML64 <- function (markdown, workingDirectory = NULL, environment = NULL) {
#   SetKnitrOptions(workingDirectory)
#   if (is.null(environment)) environment <- parent.frame()
#   html <- knitr::knit2html(text=markdown, options=c("use_xhtml", "smartypants", "mathjax", "highlight_code", "base64_images"), stylesheet = GetMarkDownCss(), envir = environment)
#
#   return(html)
# }
#
# RMD2HTML64 <- function (sourceFilePath, outputFilePath = NULL, environment = NULL) {
#   markdown <- ReadFile(sourceFilePath)
#   html <- MD2HTML64(markdown, workingDirectory = sourceFilePath, environment)
#
#   # Strip "<!DOCTYPE html>" from top of HTML document (doesn't parse properly in mail).
#   #
#   html <- sub("^<!DOCTYPE html>\n", "", html)
#
#   if (!is.null(outputFilePath)) {
#     WriteFile(text = html, fileName = outputFilePath)
#   }
#
#   return(html)
# }

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
