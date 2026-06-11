function [Kp, Ki, Kd] = p_controller(Tau, K, L)
    Kp = Tau/(K*L);
    Ki = 0;
    Kd = 0;
end
