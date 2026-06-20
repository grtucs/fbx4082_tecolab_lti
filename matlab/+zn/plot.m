function plot(t, y, L, info)
%PLOT Plota o grafico usado no metodo de Ziegler-Nichols.
%   zn.plot(t, y, L, info) plota a amostragem, a curva suavizada, a reta
%   tangente no ponto de inflexao e as marcacoes de L e 63.2%.
    t = t(:);
    y = y(:);
    ymean = info.ymean(:);

    y0 = ymean(1);
    yend = ymean(end);

    reta_tangente = info.m*(t - info.t_inf) + info.y_inf;

    figure;

    plot(t, y, "DisplayName", "Amostragem", "LineWidth", 1.5);
    hold on;
    plot(t, ymean, "DisplayName", "Amostragem filtrada", "LineWidth", 1.5);
    plot(t, reta_tangente, '--', 'Color', 'm', ...
        'DisplayName', 'Reta tangente');

    yline(y0, ':r', "HandleVisibility", "off");
    xline(L, ':r', "HandleVisibility", "off");
    xline(info.t63, ':b', "HandleVisibility", "off");
    yline(info.y63, ':b', "HandleVisibility", "off");
    yline(yend, '--k', "HandleVisibility", "off");

    plot(info.t_inf, info.y_inf, 'mp', 'MarkerSize', 8, ...
        'MarkerFaceColor', 'm', 'DisplayName', 'Ponto de inflexao');
    plot(info.t63, info.y63, 'bo', 'MarkerSize', 4, ...
        'MarkerFaceColor', 'b', 'DisplayName', '\tau em 63.2%');
    plot(L, y0, 'ro', 'MarkerSize', 4, ...
        'MarkerFaceColor', 'r', 'DisplayName', 'Ponto de interseccao L');

    xlabel('Tempo (s)');
    ylabel('Temperatura (°C)');
    ylim([19 75]);
    title('');
    legend('show', 'Location', 'best');
    grid on;
    hold off;
end
