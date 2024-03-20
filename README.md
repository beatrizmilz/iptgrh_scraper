
<!-- README.md is generated from README.Rmd. Please edit that file -->

# IPT-GRH Scraper

- Este repositório utiliza as funções do pacote
  [ComitesBaciaSP](https://github.com/beatrizmilz/ComitesBaciaSP), para
  fazer download das páginas e raspar dados do
  [SigRH](https://sigrh.sp.gov.br/).

- Existe um [Workflow com GitHub
  Actions](https://github.com/beatrizmilz/iptgrh_scraper/actions/workflows/executar-script-download-html.yaml)
  que faz download dos arquivos HTML duas vezes ao mês: dias 01 e 15 de
  cada mês. Isso é importante para ter um histório e possibilitar
  comparação.

- Autoria: [Beatriz Milz](https://github.com/beatrizmilz).

## Anotações importantes

- Em alguns casos, os links não são padronizados e por parte do período
  o arquivo `.html` coletado não corresponde à página usada, portanto há
  uma falta de dados. Os casos são os seguintes:

  - Representantes: Comitês PP, SMG, MP - Corrigido em 28/01/2022.

    - Atas: Comitês PP e SM - Corrigido em 28/01/2022.

    - Documentos: para o comitê SM, não havia uma página disponível
      exclusiva para divulgação de documentos (checado pela última vez
      em 28/01/2022 e 14/11/2022). A partir de 06/2023, foi detectado a
      presença de várias páginas que apresentam conteúdos relacionados à
      documentos, mas separadamente. Portanto, ainda não havia uma
      página disponível exclusiva para divulgação de documentos.
