function value = compare(ref, signal, Ts)
%COMPARE Calcula o RMSE entre dois sinais.
%
% value = compare(ref, signal)
% value = compare(ref, signal, Ts)
%
% Entradas:
%   ref    - Sinal de referência (Time/Data)
%   signal - Sinal a ser comparado (Time/Data)
%   Ts     - Passo de interpolação (opcional, padrão = 0.2 s)
%
% Saída:
%   value  - RMSE entre os sinais

    if nargin < 3
        Ts = 0.2;
    end

    t0 = max(ref.Time(1), signal.Time(1));
    tf = min(ref.Time(end), signal.Time(end));

    t = (t0:Ts:tf)';

    r = interp1(ref.Time,    ref.Data,    t, "linear");
    y = interp1(signal.Time, signal.Data, t, "linear");

    value = sqrt(mean((r - y).^2));
end