function R = RotationMinimizingFrame(time, r_x, r_y, r_z, time_prev, R_prev)
%ROTATIONMINIMIZINGFRAME Summary of this function goes here
%   Detailed explanation goes here

t_prev = R_prev(:,1);
% s_prev = R_prev(:,2);
r_prev = R_prev(:,3);

x = [polyval(r_x, time);
     polyval(r_y, time);
     polyval(r_z, time)];

x_prev = [polyval(r_x, time_prev);
          polyval(r_y, time_prev);
          polyval(r_z, time_prev)];

v1 = x - x_prev;
c1 = dot(v1,v1);
r_L_prev = r_prev - (2/c1)*dot(v1,r_prev)*v1;
t_L_prev = t_prev - (2/c1)*dot(v1,t_prev)*v1;

% Computing tangent vector t
vel_x = polyval(polyder(r_x), time);
vel_y = polyval(polyder(r_y), time);
vel_z = polyval(polyder(r_z), time);
vel = [vel_x; vel_y; vel_z];
t = vel / norm(vel);

v2 = t - t_L_prev;
c2 = dot(v2,v2);
r = r_L_prev - (2/c2)*dot(v2,r_L_prev)*v2;
s = cross(t,r);

% R = [t s r];
R = [t r s];

end
