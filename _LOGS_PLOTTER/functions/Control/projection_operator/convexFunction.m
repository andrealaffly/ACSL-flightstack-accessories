function [h,dh_dx] = convexFunction(x,x_e,epsilon,S)
%CONVEX_FUNCTION Convex function to compute h and dh_dx
% Convex function to compute h and dh_dx. 
% The outer convex set is an ellipsoid centered in x_e with semi-axis length described by the diagonal elements
% that populate the S matrix. If S = diag(1/a^2, 1/b^2, 1/c^2) then the semi-axis lengths are [a, b, c].
% The inner convex set is the outer convex set ellipsoid scaled by the coefficient alpha = 1/sqrt(1 + epsilon).

h = ((1 + epsilon) * (x - x_e)' * S * (x - x_e) - 1) / epsilon;

% Jacobian
dh_dx = (2 * (1 + epsilon) * (x - x_e)' * S) / epsilon;

end

