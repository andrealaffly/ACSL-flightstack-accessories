function wrapped_alpha = wrapAngleToMinusPiAndPi(alpha)
    wrapped_alpha = alpha - 2 * pi * floor((alpha + pi) / (2 * pi));
end

