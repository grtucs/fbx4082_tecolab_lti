function [Tau, K, L, info] = calc(t, y, delta_u, opts)    
    % Busca a melhor solucao para a suavização da curva
    [~, idx] = zn.optimal_inf_point(y, t, opts.smooth_min, opts.smooth_max);
    
    % Filtro gaussiano pra suavizar a curva pra derivada
    % conseguir encontrar o ponto de inflexão sem muito
    % ruido no sinal (Testei na forca bruta 26 foi o melhor)
    ymean = smoothdata(y, opts.smooth_method, idx);
    
    % Derivada primeira da curva suavizada
    dy = gradient(ymean, t);
    
    % Pega o ponto de inflexão atrvés do máximo da
    % primeira derivada
    [~, idx_inf] = max(dy);
    t_inf = t(idx_inf);
    y_inf = ymean(idx_inf);
    
    y0 = ymean(1);
    yend = ymean(end);
    
    % Reta tangente no ponto de inflexão
    m = dy(idx_inf);
    
    % Ponto em 63.2% do máximo da resposta
    y63 = y0 + 0.632*(yend - y0);
    [~, idx63] = min(abs(ymean - y63));
    t63 = t(idx63);
    
    % Encontra o L do tempo em que a reta tangente cruza
    % o eixo do tempo
    L = t_inf + (y0 - y_inf)/m;
    
    % K sendo a entrada ao degrau
    K = (yend - y0) / delta_u;
    
    % A contante de tempo Tau
    Tau = t63 - L;

    % Dados para a plotagem do gráfico de Ziegler-Nichols
    info.ymean = ymean;
    info.dy = dy;
    info.idx_inf = idx_inf;
    info.t_inf = t_inf;
    info.y_inf = y_inf;
    info.m = m;
    info.t63 = t63;
    info.y63 = y63;
end