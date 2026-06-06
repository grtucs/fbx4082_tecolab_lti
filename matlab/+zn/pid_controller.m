function [Kp, Ki, Kd] = pid_controller(Tau, K, L)
    Kp = 0.55 * Tau/(K*L);
    Ki = 0.5 / L;
    Kd = 0.5 * L;
end
