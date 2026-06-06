function [val, idx] = optimal_inf_point(y, t, janela_inicio, janela_fim)
    janelas = janela_inicio:janela_fim;
    t_inf_vals = zeros(size(janelas));

    for k = 1:length(janelas)
        janela = janelas(k);

        ymean = smoothdata(y, 'gaussian', janela);
        dy = gradient(ymean, t);

        [~, idx_inf] = max(dy);
        t_inf_vals(k) = t(idx_inf);
    end

    [val, idx] = min(t_inf_vals);
end