from Modules.Utils.discrete_time_LTI import Controller

class Controller(Controller):
	def __init__(self):
		super().__init__()

	def control_setup(self):
		self.set_signal_period(75) # Configura período para 75 iterações, cada iteração é 200 ms (não deve ser alterado)
		##### Inicio do bloco de código dos alunos #####
		
		# 1. Tempo de amostragem
		self.Ts = 15.0 # Período de amostragem exigido [cite: 25]
		
		# 2. Coeficientes do Feedforward 
		# ATENÇÃO: Substitua pelos valores exatos que obteve no MATLAB com o c2d()
		self.b0 = 9.3498  
		self.b1 = -8.6172 
		self.a1 = -0.3333 
		
		# 3. Ganhos do PID (Sintonia Ziegler-Nichols)
		# ATENÇÃO: Substitua pelos seus ganhos calculados
		self.Kp = 9.5329
		self.Ki = 0.042875
		self.Kd = 5.8309
		
		# 4. Variáveis de Estado (Memórias do sistema para t-1)
		self.r_prev = 0.0      # r[k-1] 
		self.u_ff_prev = 0.0   # u_ff[k-1] 
		self.e_prev = 0.0      # e[k-1] 
		self.integral = 0.0    # Acumulador puro da integral
		
		##### Fim do bloco de código dos alunos #####

	def control_action(self):
		temperatura = self.temperature_heater_1 - self.temperature_ambient # Temperatura relativa do sensor 1
		setpoint = self.setpoint_rel_2 # Setpoint de temperatura para o sensor 2
		atuador = 0 # Atuação do aquecedor 1
		##### Inicio do bloco de código dos alunos #####
		
		r_k = setpoint
		y_k = temperatura
		
		# a) Feedforward (Puramente Linear)
		u_ff_k = (self.b0 * r_k) + (self.b1 * self.r_prev) - (self.a1 * self.u_ff_prev)
		
		# b) PID Discreto (Puramente Linear)
		e_k = r_k - y_k
		
		P = self.Kp * e_k
		D = (self.Kd / self.Ts) * (e_k - self.e_prev)
		self.integral = self.integral + (self.Ki * self.Ts * e_k) # Integral sem travas (Linear)
		
		u_pid_k = P + self.integral + D
		
		# c) Ação Total de Controle
		atuador = u_ff_k + u_pid_k
			
		# d) Atualização das Memórias
		self.r_prev = r_k
		self.u_ff_prev = u_ff_k
		self.e_prev = e_k
		
		##### Fim do bloco de código dos alunos #####
		self.actuator_heater_1 = atuador