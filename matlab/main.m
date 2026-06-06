clear; clc; close all;

% Referência
data = readtable(fullfile(pwd, "dataset", "Referência.csv"));

t = data.TIME / 1000;
sp2 = data.SP2_REL;

ref = timeseries(sp2, t);

% Planta (Primeira ordem com atraso por Ziegler-Nichols)
data = readtable(fullfile(pwd, "dataset", "Dinâmica.csv"));
t = data.TIME / 1000; % Tempo de amostragem [s]
y = data.H2_TEMP; % Temperatura do sensor 2
u = data.H1_D_PWM; % Amplitude do degrau aplicado
delta_u = max(u); % Degrau de amplitude aplicado

% Opcoes de suavizacao da curva para o ponto de inflexao.
zn_opts.smooth_method = 'gaussian';
zn_opts.smooth_min = 1;
zn_opts.smooth_max = 500;

[Tau, K, L] = zn.calc(t, y, delta_u, zn_opts);

% Controlador
% [Kp] = zn.p_controller(Tau, K, L);
% [Kp, Ki] = zn.pi_controller(Tau, K, L);
[Kp, Ki, Kd] = zn.pid_controller(Tau, K, L);

% Feed-Forward
Lb = 100;