function value = cost(r, y)
    value = sqrt(mean((r(:) - y(:)).^2));
end