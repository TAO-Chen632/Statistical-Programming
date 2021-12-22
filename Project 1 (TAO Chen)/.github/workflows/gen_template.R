library(magrittr)

parsermd::parse_rmd("proj1.Rmd") %>% 
  parsermd::as_tibble() %>% 
  dplyr::filter(sec_h3 != "Data" & !is.na(sec_h3)) %>%
  dplyr::filter(!(sec_h4 == "Code" & type == "rmd_markdown")) %>%
  parsermd::rmd_template(keep_content = TRUE, keep_headings = TRUE) %>%
  saveRDS(here::here(".github/workflows/template.rds"))
