function [Kp, Ki, Kd] = pi_controller(Tau, K, L)
    Kp = 0.9 * Tau/(K*L);
    Ki = 0.3 / L;
    Kd = 0;
end
