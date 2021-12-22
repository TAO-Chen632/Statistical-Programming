library(magrittr)

parsermd::parse_rmd("hw1.Rmd") %>% 
  parsermd::as_tibble() %>% 
  dplyr::filter(type != "rmd_heading") %>% 
  dplyr::slice(-1, -6,-8) %>% 
  parsermd::rmd_template(keep_content = TRUE) %>%
  saveRDS(here::here(".github/workflows/template.rds"))
