clear; clc; close all;

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
N = 100; % Contante derivativa do PID
Lb = 100; % Constante do Feed-Forward

% Plotagem das figuras
output = sim(fullfile(pwd, "1-Tempo contínuo", "simulacao_continuo.slx"));

figure;
plot(ref.Time, ref.Data, 'LineWidth', 2, 'DisplayName', 'Referência');
hold on; grid on; box on;
plot(output.y.Time, output.y.Data, "DisplayName", "PID");
legend('Location', 'best');
xlim([0 900]);
ylim([-5 45]);