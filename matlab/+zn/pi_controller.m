function [Kp, Ki] = pi_controller(Tau, K, L)
    Kp = 0.9 * Tau/(K*L);
    Ki = 0.3 / L;
end
