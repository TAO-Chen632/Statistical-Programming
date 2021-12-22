library(magrittr)

parsermd::parse_rmd("hw2.Rmd") %>% 
  parsermd::as_tibble() %>% 
  dplyr::filter(type != "rmd_heading") %>% 
  dplyr::slice(-(1:3)) %>%
  dplyr::slice(-(9:10)) %>% 
  parsermd::rmd_template(keep_content = TRUE) %>%
  saveRDS(here::here(".github/workflows/template.rds"))
