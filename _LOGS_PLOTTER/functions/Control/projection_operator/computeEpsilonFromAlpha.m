function epsilon = computeEpsilonFromAlpha(alpha)
%COMPUTEEPSILONFROMALPHA 
% Compute the epsilon parameter from the scaling coefficient alpha.

epsilon = 1 / alpha^2 - 1;

end

