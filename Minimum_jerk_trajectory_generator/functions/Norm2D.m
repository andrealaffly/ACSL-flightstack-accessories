function norm_value = Norm2D(poly_coef_x,poly_coef_y,t)
%NORM2D Computes the 2D norm from polynomial coefficients of the components of the vector 
%   Detailed explanation goes here

norm_value = sqrt((polyval(poly_coef_x,t))^2 + (polyval(poly_coef_y,t))^2);


end

