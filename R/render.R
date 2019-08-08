library(emayili)
library(magrittr)

#' Title
#'
#' @param msg
#' @param content
#' @param type
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

email <- envelope()

email <- email %>%
  from("Sentinel@derivco.co.za") %>%
  to("collierab@gmail.com")

email <- email %>% subject("This is a plain text message!")

email <- email %>% render("test.Rmd", quiet = FALSE)

cat(message(email))

smtp <- server(host = "mail.mgsops.net",
               port = 25
               # username = "andrew@exegetic.biz",
               # password = "m2Q9WSbvjf7U"
               )

smtp(email, verbose = TRUE)

