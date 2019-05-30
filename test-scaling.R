library(dplyr)
library(stringi)
library(purrr)
# devtools::install_github("DavisVaughan/furrr")
library(furrr)
library(digest)
library(here)
library(tictoc)
library(emayili)

PASSWORD = Sys.getenv("PASSWORD2")
USERNAME = Sys.getenv("USERNAME2")

ATTACHMENT = here("inst/sample-attachment.xls")

smtp <- server(host = "smtp.gmail.com", port = 587, username = USERNAME, password = PASSWORD)

NMSG = 10

messages <- tibble(
  to = paste(sapply(1:NMSG, digest), "mailinator.com", sep = "@"),
) %>%
  mutate(
    subject = sprintf("Message #%d", row_number()),
    body = sapply(
      sample(1:10, NMSG, replace = TRUE),
      function(npar) stri_rand_lipsum(npar, FALSE) %>% paste(collapse = "\n\n")
    )
  )

tic()
#
messages %>%
  pwalk(function(to, subject, body) {
    envelope() %>%
      from(USERNAME) %>%
      to(to) %>%
      subject(subject) %>%
      body(body) %>%
      attachment(ATTACHMENT) %>%
      smtp()
  })
#
toc()

plan(multiprocess)

tic()
#
messages %>%
  future_pwalk(function(to, subject, body) {
    envelope() %>%
      from(USERNAME) %>%
      to(to) %>%
      subject(subject) %>%
      body(body) %>%
      attachment(ATTACHMENT) %>%
      smtp()
  })
#
toc()
