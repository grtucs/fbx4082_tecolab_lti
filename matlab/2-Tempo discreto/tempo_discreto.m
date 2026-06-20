clear; clc; 

% Referência
data = readtable(fullfile(pwd, "dataset", "Referência.csv"));
t = data.TIME / 1000;
sp2 = data.SP2_REL;
ref = timeseries(sp2, t);

% Planta (Primeira ordem com atraso por Ziegler-Nichols)
data = readtable(fullfile(pwd, "dataset", "Dinâmica.csv"));
t = data.TIME / 1000; % Tempo de amostragem [s]
y = data.H1_TEMP; % Temperatura do sensor 1
u = data.H1_D_PWM; % Amplitude do degrau aplicado
delta_u = max(u); % Degrau de amplitude aplicado

% Opcoes de suavizacao da curva para o ponto de inflexao.
zn_opts.smooth_method = 'gaussian';
zn_opts.smooth_min = 1;
zn_opts.smooth_max = 500;

[Tau, K, L] = zn.calc(t, y, delta_u, zn_opts);

% Controlador
Ts = 15; % Tempo de amostragem [s];

% =========================================================================
% Valores calculados por ZN
% =========================================================================
% [Kp, Ki, Kd] = zn.p_controller(Tau, K, L);
% [Kp, Ki, Kd] = zn.pi_controller(Tau, K, L);
% [Kp, Ki, Kd] = zn.pid_controller(Tau, K, L);
% [Kp, Ki, Kd] = zn.pd_controller(Tau, K, L);
% N = 100; % Constante derivativa do PID
% Lb = 100; % Constante do Feed-Forward
% ------------------------------------------------------------------------- 
% Esses valores acabaram nao sendo usados porque optamos pelos valores mais
% otimizados.
% -------------------------------------------------------------------------

Kp = 13.471842;
Ki = 0;
Kd = 6.014499;
Lb = 6.603425;
N  = 100.000000;

% Discretizando as funcoes
ff_s = tf([77 1], [K*Lb K]);
ff_z = c2d(ff_s, Ts, "tustin");

% Extraindo o numerador/denominador da FF(s)
[ff_num_z, ff_den_z] = tfdata(ff_z, "v");

% Discretização da planta
Gs = tf(K, [Tau 1], "InputDelay", L);
c2d(Gs, Ts, "zoh");

% Lendo os dados da simulação
exp_data = readtable(fullfile(pwd, "dataset", "Experimento.csv"));
exp_t = exp_data.TIME / 1000;
exp_h2 = exp_data.H2_TEMP - exp_data.AMB_TEMP;
exp_ref = timeseries(exp_h2, exp_t);

% Pega a saída da simulaçao
output = sim(fullfile(pwd, "2-Tempo discreto", "simulacao_discreto.slx"));

% Erro RMSE
rmse_experimento = rmse.compare(ref, exp_ref);
rmse_simulacao = rmse.compare(ref, output.y);
fprintf("RMSE: Referência x Simulação = %.4f\n", rmse_simulacao);
fprintf("RMSE: Referência x Experimento = %.4f\n", rmse_experimento);

%% Plotagem das figuras
figure;
plot(ref.Time, ref.Data, 'LineWidth', 2, 'DisplayName', 'Referência');
hold on; grid on; box on;
plot(output.y.Time, output.y.Data, "LineWidth", 1.5, "DisplayName", "Simulação");
hold on; grid on; box on;
plot(exp_ref.Time, exp_ref.Data, "LineWidth", 1.5, "DisplayName", "Experimento");
legend('Location', 'best');
xlabel('Tempo (s)');
ylabel('Temperatura (°C)');
xlim([0 900]);
ylim([-5 45]);
