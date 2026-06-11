function [Kp, Ki, Kd] = pd_controller(Tau, K, L)
    Kp = 0.55 * Tau/(K*L);
    Ki = 0;
    Kd = 0.5 * L;
end
