clear; clc; close all;

data = readtable(fullfile(pwd, "dataset", "Dinâmica.csv"));
t = data.TIME / 1000; % Tempo de amostragem [s]
y = data.H2_TEMP; % Temperatura do sensor 2
u = data.H1_D_PWM; % Amplitude do degrau aplicado
delta_u = max(u); % Degrau de amplitude aplicado

% Opcoes de suavizacao da curva para o ponto de inflexao.
zn_opts.smooth_method = 'gaussian';
zn_opts.smooth_min = 1;
zn_opts.smooth_max = 500;

[~, ~, L, info] = zn.calc(t, y, delta_u, zn_opts);
zn.plot(t, y, L, info);
