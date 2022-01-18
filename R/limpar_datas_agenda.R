limpar_datas_agenda <- function(base_agenda){
  base_agenda |>
    tidyr::separate(
      col = data_reuniao_mes_ano,
      into =
        c("data_reuniao_mes", "data_reuniao_ano"),
      sep = "/",
      remove = FALSE
    ) |>
    dplyr::mutate(
      data_reuniao_ano = stringr::str_trim(data_reuniao_ano),
      data_reuniao_mes = stringr::str_trim(data_reuniao_mes),

      data_reuniao_ano =  dplyr::case_when(
        as.numeric(data_reuniao_ano) >= 0 &
          as.numeric(data_reuniao_ano) < 80 ~ paste0("20", stringr::str_trim(data_reuniao_ano)),
        TRUE ~ paste0("19", stringr::str_trim(data_reuniao_ano)),
      ),
      data_reuniao_mes =  dplyr::case_when(
        data_reuniao_mes == "JAN" ~ 1,
        data_reuniao_mes == "FEV" ~ 2,
        data_reuniao_mes == "MAR" ~ 3,
        data_reuniao_mes == "ABR" ~ 4,
        data_reuniao_mes == "MAI" ~ 5,
        data_reuniao_mes == "JUN" ~ 6,
        data_reuniao_mes == "JUL" ~ 7,
        data_reuniao_mes == "AGO" ~ 8,
        data_reuniao_mes == "SET" ~ 9,
        data_reuniao_mes == "OUT" ~ 10,
        data_reuniao_mes == "NOV" ~ 11,
        data_reuniao_mes == "DEZ" ~ 12

      ),
      data_reuniao = lubridate::as_date(
        paste0(
          data_reuniao_ano,
          "-",
          data_reuniao_mes,
          "-",
          data_reuniao_dia
        )
      )
    ) |>
    dplyr::select(-data_reuniao_mes,-data_reuniao_ano)

}
