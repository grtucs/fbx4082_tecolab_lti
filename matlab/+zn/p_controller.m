function [Kp] = p_controller(Tau, K, L)
    Kp = Tau/(K*L);
end
