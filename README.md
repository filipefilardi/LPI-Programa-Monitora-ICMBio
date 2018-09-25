# LPI-Programa-Monitora-ICMBio

Função **lpi_icmbio** para cálculo do LPI (Living Planet Index) a partir de dados do Programa Monitora-ICMBio

O que a função **lpi_icmbio** faz:

(1) organiza os dados do programa Monitora-ICMBio (planilha mastoaves), colocando-os no formato exigido pelo pacote **rlpi**
(2) cria um subset dos dados acima com a UC e o grupo taxonômico de interesse (mamíferos, aves)
(3) chama a função **LPIMain** para cálculo do LPI e geração de gráficos.

O pacote **rlpi** foi desenvolvido pela Zoological Society of London e está disponível para download (com instruções de instalação, etc.) no endereço https://github.com/Zoological-Society-of-London/rlpi

A função **lpi_icmbio** ainda precisa de vários ajustes e qualquer contribuição é bem vinda. Algumas das necessidades já identificadas já estão indicadas como anotações no próprio script **lpi_icmbio**

Por exemplo, verificou-se que os intervalos de confiança nos gráficos gerados estão muito altos (ver figura abaixo com exemplo da RESEX Cazumbá-Iracema). Em parte isso se deve ao pequeno tamanho amostral por UC (três trilhas somente), mas sem dúvida isso se deve também à inclusão de todas as espécies no cálculo. Provavelmente precisaremos definir critérios para inclusão de espécies no cálculo do LPI e criar o código para que a função faça isso de forma automatizada. Muitos outros problemas ainda precisam ser identificados.

![image](https://user-images.githubusercontent.com/39089964/46036611-4e12e780-c0dc-11e8-94d2-6e66d98edc30.png)

