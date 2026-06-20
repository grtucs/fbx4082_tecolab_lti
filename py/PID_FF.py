from Modules.Utils.discrete_time_LTI import Controller

# ------------------------------------------------------------------------------
# CLASSE DO FEED-FORWARD DISCRETIZADO POR TUSTIN
# ------------------------------------------------------------------------------
class FeedForwardTustin:
  def __init__(self, Tau, K, Lb, Ts):
    # s ~= (2/Ts)*(z - 1)/(z + 1).
    alpha = 2.0 / Ts # Isso é só de placeholder.

    # O feed-forward antecipa a ação necessária a partir do setpoint usando o
    # modelo da planta.
    # FF(s) = (Tau*s + 1)/(K*Lb*s + K).
    #
    # Depois de Tustin, ela vira:
    # ff[k] = b0*r[k] + b1*r[k-1] - a1*ff[k-1].
    den = K * Lb * alpha + K
    self.b0 = (Tau * alpha + 1.0) / den
    self.b1 = (-Tau * alpha + 1.0) / den
    self.a1 = (-K * Lb * alpha + K) / den

    # Memorias: entrada anterior e saida anterior.
    self.x1 = 0.0  # ref[k-1]
    self.y1 = 0.0  # ff[k-1]

  def compute(self, refk):
    # Calcula a saida atual e depois desloca as memorias para a proxima amostra.
    output = self.b0 * refk + self.b1 * self.x1 - self.a1 * self.y1
    self.x1 = refk
    self.y1 = output
    return output

# ------------------------------------------------------------------------------
# CLASSE DO PID DISCRETIZADO POR TUSTIN
# ------------------------------------------------------------------------------
class PIDTustin:
  def __init__(self, Kp, Ki, Kd, N, Ts):
    # O PID continuo usado aqui e:
    # C(s) = Kp + Ki/s + Kd*N*s/(s + N).
    alpha = 2.0 / Ts # Placeholder da aproximação

    # Depois da transformacao de Tustin, o PID vira uma equacao de segunda
    # ordem, por isso aparecem tres coeficientes no numerador e tres no
    # denominador.
    den = [
      alpha + N,
      -2.0 * alpha,
      -(N - alpha)
    ]

    num = [
      Kp * den[0] + (Ki / alpha) * den[0] + Kd * N * alpha,
      Kp * den[1] + (Ki / alpha) * (2.0 * N) - 2.0 * Kd * N * alpha,
      Kp * den[2] + (Ki / alpha) * (N - alpha) + Kd * N * alpha
    ]

    self.b0 = num[0] / den[0]
    self.b1 = num[1] / den[0]
    self.b2 = num[2] / den[0]
    self.a1 = den[1] / den[0]
    self.a2 = den[2] / den[0]

    # Memórias: dois erros anteriores e duas saidas anteriores.
    self.x1 = 0.0  # e[k-1]
    self.x2 = 0.0  # e[k-2]
    self.y1 = 0.0  # pid[k-1]
    self.y2 = 0.0  # pid[k-2]

  def compute(self, ek):
    # Os termos com erro atual e erros antigos formam o numerador; os termos
    # com saidas antigas representam a realimentacao interna da funcao
    output = (
      self.b0 * ek
      + self.b1 * self.x1
      + self.b2 * self.x2
      - self.a1 * self.y1
      - self.a2 * self.y2
    )

    # Desloca as memorias: o valor atual passa a ser o anterior na proxima
    # amostra
    self.x2 = self.x1
    self.x1 = ek
    self.y2 = self.y1
    self.y1 = output
    return output

# ------------------------------------------------------------------------------
# CLASSE DO CONTROLADOR
# ------------------------------------------------------------------------------
class Controller(Controller):
  def __init__(self):
    super().__init__()

  def control_setup(self):
    self.set_signal_period(75) # Configura período para 75 iterações, cada iteração é 200 ms (não deve ser alterado)

    ##### Inicio do bloco de código dos alunos #####
    self.Ts = 15.0

    # Estes sao os mesmos ganhos ajustados no script MATLAB de tempo discreto.
    self.Kp = 13.471842
    self.Ki = 0.000000
    self.Kd = 6.014499
    self.N = 100.000000
    self.Lb = 6.603425

    # Valores de Zieger-Nichols
#     self.Tau = 188.0271
    self.Tau = 77.0
    self.K = 0.92

    self.feed_forward = FeedForwardTustin(self.Tau, self.K, self.Lb, self.Ts)
    self.pid = PIDTustin(self.Kp, self.Ki, self.Kd, self.N, self.Ts)
    ##### Fim do bloco de código dos alunos #####

  def control_action(self):
    temperatura = self.temperature_heater_1 - self.temperature_ambient # Temperatura relativa do sensor 1
    setpoint = self.setpoint_rel_2 # Setpoint de temperatura para o sensor 2
    atuador = 0 # Atuação do aquecedor 1

    ##### Inicio do bloco de código dos alunos #####
    refk = setpoint   # Referencia
    yk = temperatura  # Temperatura medida
    ek = refk - yk    # erro de u[k]

    uff_k = self.feed_forward.compute(refk)
    upid_k = self.pid.compute(ek)

    # A acao aplicada ao aquecedor soma a acão do feed-forward com a
    # correção do PID baseada no erro
    uk = uff_k + upid_k
    atuador = uk
    ##### Fim do bloco de código dos alunos #####
    
    self.actuator_heater_1 = atuador
