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
% [Kp, Ki, Kd] = zn.p_controller(Tau, K, L);
% [Kp, Ki, Kd] = zn.pi_controller(Tau, K, L);
[Kp, Ki, Kd] = zn.pid_controller(Tau, K, L);
% [Kp, Ki, Kd] = zn.pd_controller(Tau, K, L);
N = 100; % Constante derivativa do PID
Lb = 100; % Constante do Feed-Forward
Ts = 15; % Tempo de amostragem;

% Discretizando as funcoes
ff_s = tf([Tau 1], [K*Lb K]);
ff_z = c2d(ff_s, Ts, "tustin");

% Extraindo o numerador/denominador da FF(s)
[ff_num_z, ff_den_z] = tfdata(ff_z, "v");

% Lendo os dados da simulação
exp_data = readtable(fullfile(pwd, "dataset", "Simulação 1.csv"));
exp_t = exp_data.TIME / 1000;
exp_sp2 = exp_data.SP2_REL;
exp_ref = timeseries(exp_sp2, exp_t);

% Plotagem das figuras
output = sim(fullfile(pwd, "2-Tempo discreto", "simulacao_discreto.slx"));

figure;
plot(ref.Time, ref.Data, 'LineWidth', 2, 'DisplayName', 'Referência');
hold on; grid on; box on;
plot(output.y.Time, output.y.Data, "DisplayName", "Simulação");
hold on; grid on; box on;
plot(exp_ref.Time, exp_ref.Data, "DisplayName", "Experimento");
legend('Location', 'best');
xlim([0 900]);
ylim([-5 45]);