library(dplyr)
library(emayili)

smtp <- server(
  host = "mail.mgsops.net",
  port = 25
)

email <- envelope() %>%
  from("email@derivco.co.za") %>%
  to("Andrew_Collier@derivco.co.za")

email <- email %>% subject("This is a plain text message!")

email <- email %>% render("foo.Rmd", quiet = FALSE)

cat(message(email))

smtp(email, verbose = TRUE)

