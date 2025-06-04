function x_d_modified = projectionVector(x,x_d,x_e,epsilon,S)
%PROJECTIONVECTOR Summary of this function goes here
%   Function to project the vector x_d based on the convexFunction
% x_d: derivative wrt time of x (RHS of its dynamics equation)

[h,dh_dx] = convexFunction(x,x_e,epsilon,S);

x_d_modified = x_d - (h > 0) * (dh_dx * x_d > 0) * h * (dh_dx' * dh_dx) ...
                / (dh_dx * dh_dx') * x_d;

end

