# Identificação de uma planta térmica e projeto de um controlador Linear Invariante no Tempo digital para o sistema [TeCoLab](https://github.com/ytcsc/TeCoLab)

**Gabriel Rodrigues Tavares, Gabriel Tomazzoni Mazzarotto**

Este trabalho apresenta a identificação e o controle digital de uma planta
térmica da plataforma [TeCoLab](https://github.com/ytcsc/TeCoLab). A partir de
dados experimentais foi obtido um modelo matemático da planta, utilizado no
projeto de um controlador digital Linear Invariante no Tempo capaz de seguir a
referência especificada. O desempenho foi avaliado por meio de simulações,
ensaios experimentais e mensurado a partir de uma figura de mérito Root Mean
Squared Error.

### Palavras-chave

controle digital, Ziegler-Nichols, controlador PID, feed-forward, TeCoLab,
planta térmica

# Introdução

Este trabalho tem como objetivo identificar, a partir de um sistema físico
chamado [TeCoLab](https://github.com/ytcsc/TeCoLab), a dinâmica de uma planta
térmica e aplicar um controlador Linear Invariante no Tempo em tempo discreto
com um tempo de amostragem de 15 s que seja capaz de seguir uma curva de
referência com o menor erro possível tendo como modelo ideal erro zero em regime
permanente.

Partindo desse pressuposto utilizaremos técnicas de identificação da dinâmica da
planta nos sensores, como o ensaio ao degrau de Ziegler-Nichols, e conceitos de
controladores Linear Invariante no Tempo como PID para encontrar uma aproximação
com o menor erro possível a partir de uma curva de referência.

A validação dos métodos aplicados será feita a partir de simulações e ensaios
físicos no próprio equipamento do [TeCoLab](https://github.com/ytcsc/TeCoLab).

# Modelagem e identificação da planta

A partir de um ensaio ao degrau, com entrada de amplitude 50 °C aplicada ao
aquecedor 1, identificou-se a dinâmica da planta. A realimentação baseia-se no
sensor 1, enquanto o objetivo de seguimento refere-se à temperatura relativa
registrada pelo sensor 2. Adotou-se a abordagem de Ziegler-Nichols por ensaio ao
degrau com um modelo First Order Plus Dead Time, obtendo-se uma aproximação para
cada sensor, conforme as [Equações 1](#equação-1) e [2](#equação-2).

###### Equação 1

$$ G_1(s) = \frac{0.92}{188.03s + 1} e^{-6.37s} $$

###### Equação 2

$$ G_2(s) = \frac{0.91}{183.94s + 1} e^{-11.66s} $$

O modelo do sensor 1, usado no projeto, foi discretizado por Zero-Order Holder
com $T_s = 15$ s, resultando na [Equação 6](#equação-6).

# Projeto do controlador

O controlador foi projetado com uma estrutura Proporcional Derivativo paralela.
Os ganhos iniciais foram obtidos pelo método de Ziegler-Nichols a partir da
[Equação 1](#equação-1) e posteriormente ajustados utilizando o Root Mean
Squared Error, de acordo com a [Equação 3](#equação-3), como critério de
desempenho.

###### Equação 3

$$ RMSE = \sqrt{\frac{1}{N}\sum\_{k=1}^{N}\left(r[k]-y[k]\right)^2} $$

O controlador Proporcional Derivativo obtido é dado pela [Equação
4](#equação-4).

###### Equação 4

$$ C\_{pd}(s) = 13.472 + \frac{601.4s}{s+100} $$

Apesar do bom desempenho dinâmico, o controlador Proporcional Derivativo
apresentou Erro em Regime Permanente significativo durante o seguimento da
referência.

Para reduzir esse erro, foi adicionada uma ação Feed-Forward baseada em um
modelo inverso da planta combinado com um filtro que define a dinâmica desejada
em malha fechada [[1], [2], [3], [4], [5]](#referências-bibliográficas). Esse
tipo de controle utiliza o modelo do processo para antecipar a ação necessária
ao seguimento da referência [[6]](#referências-bibliográficas).

Neste trabalho o Feed-Forward foi implementado com o modelo inverso da planta da
[Equação 1](#equação-1) em paralelo com o controlador Proporcional Derivativo,
além de um filtro passa-baixas para garantir causalidade. O controlador
resultante é dado pela [Equação 5](#equação-5).

###### Equação 5

$$ C\_{ff}(s) = \frac{188.0271s + 1}{6.075s + 0.92} $$

A [Figura 1](#figura-1) mostra a estrutura completa do controlador. Nela, o
Feed-Forward atua diretamente sobre a referência, enquanto o controlador
Proporcional Derivativo corrige o erro pela realimentação do sistema.

###### Figura 1

![Bloco do controlador](./gh/images/Bloco-Controlador.svg)

**Estrutura do controlador proposto, composta por uma ação Feed-Forward aplicada
à referência e uma ação Proporcional Derivativo baseada na realimentação do
sistema.**

O controlador foi discretizado pelo método de Tustin, aplicado às ações
Proporcional Derivativo e Feed-Forward. Nesse método, o operador contínuo $s$ é
aproximado pela transformação bilinear ([Equação 6](#equação-6)).

###### Equação 6

$$ s \approx \frac{2}{T_s}\frac{z-1}{z+1} $$

em que $T_s$ é o período de amostragem definido como $T_s = 15$ s.

O modelo da planta foi discretizado por Zero-Order Holder, resultando na
[Equação 7](#equação-7).

###### Equação 7

$$ G(z) = z^{-1}\frac{0.0413z + 0.0293}{z - 0.9233} $$

# Resultado das simulações

As simulações foram realizadas no ambiente Simulink utilizando a planta
identificada na [Equação 1](#equação-1) e os controladores apresentados nas
[Equações 4](#equação-4) e [5](#equação-5). Para aproximar as condições
experimentais, foi adicionado ruído branco à saída da planta e um bloco de
saturação para representar a potência máxima do aquecedor.

Os resultados demonstram que a estratégia composta pelo controlador Proporcional
Derivativo e Feed-Forward foi capaz de acompanhar a referência com baixo erro de
seguimento no transitório e em regime permanente.

# Resultados experimentais

O controlador projetado foi implementado em Python e embarcado no
[TeCoLab](https://github.com/ytcsc/TeCoLab). O sistema foi submetido à mesma
curva de referência utilizada nas simulações. Os resultados experimentais
apresentaram comportamento compatível com o previsto na simulação, mantendo o
erro de seguimento da referência baixo.

# Comparação entre simulação e experimento

A [Figura 2](#figura-2) compara os resultados de simulação e experimentais sobre
a mesma referência. Adotando o Root Mean Squared Error ([Equação 3](#equação-3))
sobre o erro de seguimento da temperatura relativa do sensor 2, o sistema
simulado apresentou

$$ RMSE = 1.3567\ ^\circ C $$

e o ensaio experimental

$$ RMSE = 2.2956\ ^\circ C $$

Em ambos os casos a estratégia Proporcional Derivativo com Feed-Forward
acompanhou a referência no transitório e em regime permanente, recuperando-se
após a perturbação aos 10 minutos.

###### Figura 2

![Resultados](./gh/images/Resultados.svg)

**Comparação entre os resultados simulado e experimental quanto ao seguimento da
referência de temperatura relativa do sensor 2.**

# Análise das discrepâncias observadas

A diferença entre os valores de Root Mean Squared Error simulado e experimental
é atribuída a fatores não contemplados pelo modelo First Order Plus Dead Time:
ruído de medição, atrasos de transporte e dinâmica térmica não modelada, além da
saturação de potência do aquecedor.

Contribui ainda a estrutura do problema, em que o controlador é realimentado
pelo sensor 1 enquanto o erro é avaliado no sensor 2, cuja diferença de
localização introduz dinâmica adicional não capturada pelo modelo.

Apesar dessas divergências, a proximidade entre os valores de Root Mean Squared
Error indica que o modelo representa adequadamente a planta e que a estratégia
de controle mantém bom desempenho experimental.

# Referências bibliográficas

\[1] Alessandro Scamacio, Patrick Gruber, Stefano De Pinto, and Aldo Sorniotti,
"Anti-jerk controllers for automotive applications: A review," _Annual Reviews
in Control_, vol. 50, pp. 174–189, 2020.

\[2] Martin Bruce, Bo Egardt, and Stefan Pettersson, "On powertrain oscillation
damping using feedforward and LQ feedback control," in _IEEE Conference on
Control Applications (CCA)_, 2005.

\[3] Takayuki Karikomi, Kazuhiro Itou, Takashi Okubo, and Shinji Fujimoto,
"Development of the shaking vibration control for electric vehicles," in
_SICE-ICASE International Joint Conference_, 2006.

\[4] Hiroshi Yamaura, Masao Ishihama, and Kazuhiko Togai, "Design and evaluation
of output profile shaping of an internal combustion engine for noise & vibration
improvement," _SAE International Journal of Engines_, vol. 7, no. 3, pp.
1514–1522, 2014.

\[5] Hiroshi Kawamura, Kazuhiro Ito, Takayuki Karikomi, and Takashi Kume,
"Highly-responsive acceleration control for the Nissan LEAF electric vehicle,"
in _SAE Technical Paper 2011-01-0397_, 2011.

\[6] Karl Johan Åström and Richard M. Murray, _Feedback Systems: An Introduction
for Scientists and Engineers_, 2nd ed., Princeton University Press, Princeton, 2021.

---

## Arquivos

### Arquivo do paper

- `latex/out/Identificação_de_uma_planta_térmica_e_projeto_de_um_controlador_LIT_digital_para_o_sistema_TeCoLab.pdf`

### Controlador usado no experimento

- `py/PID_FF.py` \- Controlador usado no projeto

### Arquivos de referência

- `matlab/dataset/Dinâmica.csv` \- Curva de referência obtido pelo experimento de
  impulso ao degrau para obter a dinâmica de Ziegler-Nichols;
- `matlab/dataset/Referência.csv` \- Curva de referência desejada a ser obtida
  pelo experimento;
- `matlab/dataset/Experimento.csv` \- Curva obtida pelo controlados desenvolvido.

### Simulações (Simulink)

- `matlab/1-Tempo contínuo/simulacao_continuo.slx` \- Simulação em tempo contínuo;
- `matlab/2-Tempo discreto/simulacao_discreto.slx` \- Simulação em tempo
  discreto.
