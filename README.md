# LPI-Programa-Monitora-ICMBio

Função **lpi_icmbio** para cálculo do LPI (Living Planet Index) a partir de dados do Programa Monitora-ICMBio

O que a função **lpi_icmbio** faz:

(1) organiza os dados do programa Monitora-ICMBio (planilha mastoaves), colocando-os no formato exigido pela função **rlpi**
(2) cria um subset dos dados acima com a UC e o grupo taxonômico de interesse (mamíferos, aves)
(3) chama a função **rlpi** para cálculo do LPI e geração de gráficos.

A função **rlpi** foi desenvolvida pela Zoological Society of London e está disponível para download (com instruções de instalação, etc.) no endereço https://github.com/Zoological-Society-of-London/rlpi

A função **lpi_icmbio** ainda precisa de vários ajustes e qualquer contribuição é bem vinda. Algumas das necessidades já identificadas já estão indicadas como anotações no próprio script **lpi_icmbio**

Por exemplo, verificou-se que os intervalos de confiança nos gráficos gerados estão muito altos (ver figura abaixo). EM parte isso se deve ao pequeno tamanho amostral por UC (três trilhas somente), mas sem dúvida isso se deve também à inclusão de todas as espécies no cálculo. Provavelmente precisaremos definir critérios para inclusão de espécies no cálculo do LPI.



