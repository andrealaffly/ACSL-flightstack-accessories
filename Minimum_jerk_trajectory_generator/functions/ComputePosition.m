function pos = ComputePosition(t, r_x, r_y, r_z)
%COMPUTEPOSITION Summary of this function goes here
%   Detailed explanation goes here


% Computing tangent vector T
r_x_ev = polyval(r_x, t);
r_y_ev = polyval(r_y, t);
r_z_ev = polyval(r_z, t);

pos = [r_x_ev; r_y_ev; r_z_ev];

end

