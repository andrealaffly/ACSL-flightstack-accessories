function R = FrenetSerretFrame(t, r_x, r_y, r_z)
%FRENETSERRETFRAME Summary of this function goes here
%   Detailed explanation goes here

% Computing tangent vector T
dr_x = polyval(polyder(r_x), t);
dr_y = polyval(polyder(r_y), t);
dr_z = polyval(polyder(r_z), t);

dr = [dr_x; dr_y; dr_z];
T = dr / norm(dr);

% Computing binormal vector B
ddr_x = polyval(polyder(polyder(r_x)), t);
ddr_y = polyval(polyder(polyder(r_y)), t);
ddr_z = polyval(polyder(polyder(r_z)), t);

ddr = [ddr_x; ddr_y; ddr_z];

B = cross(dr,ddr) / norm(cross(dr,ddr));

% Computing normal vector N

N = cross(B,T);

R = [T N B];


end

