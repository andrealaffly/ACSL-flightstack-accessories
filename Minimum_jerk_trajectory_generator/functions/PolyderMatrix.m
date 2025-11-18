function poly_coeff_matrix_out = PolyderMatrix(poly_coeff_matrix_in)
%POLYDERMATRIX derivative of the piecewise polynomial coefficient matrix
%   Detailed explanation goes here

poly_coeff_matrix_in_size = size(poly_coeff_matrix_in);

poly_coeff_matrix_out = zeros(poly_coeff_matrix_in_size(1), poly_coeff_matrix_in_size(2)-1);

for i=1:poly_coeff_matrix_in_size(1)
    poly_coeff_matrix_out(i,:) = polyder(poly_coeff_matrix_in(i,:));
end


end

