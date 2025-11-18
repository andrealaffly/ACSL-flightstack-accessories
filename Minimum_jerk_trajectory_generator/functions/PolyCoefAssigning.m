function [poly_coeff_matrix_out_x,...
          poly_coeff_matrix_out_y,...
          poly_coeff_matrix_out_z] = PolyCoefAssigning(poly_coeff_matrix_in)
%POLYCOEFASSIGNING Assigning polynomial coefficients to designated
%variables
%   Detailed explanation goes here

poly_coeff_matrix_in_size = size(poly_coeff_matrix_in);

poly_coeff_matrix_out_size = [poly_coeff_matrix_in_size(1)/3, poly_coeff_matrix_in_size(2)];

poly_coeff_matrix_out_x = zeros(poly_coeff_matrix_out_size(1), poly_coeff_matrix_out_size(2));
poly_coeff_matrix_out_y = zeros(poly_coeff_matrix_out_size(1), poly_coeff_matrix_out_size(2));
poly_coeff_matrix_out_z = zeros(poly_coeff_matrix_out_size(1), poly_coeff_matrix_out_size(2));

for i=0:poly_coeff_matrix_out_size(1)-1
    poly_coeff_matrix_out_x(i+1,:) = poly_coeff_matrix_in(3*i + 1,:);
    poly_coeff_matrix_out_y(i+1,:) = poly_coeff_matrix_in(3*i + 2,:);
    poly_coeff_matrix_out_z(i+1,:) = poly_coeff_matrix_in(3*i + 3,:);

end


end

