function yaw_dot_dot = YawDotDotComputation(Vx_coef,Vy_coef,...
                                            Ax_coef,Ay_coef,...
                                            Jx_coef,Jy_coef,...
                                            t)
%YAWDOTDOTCOMPUTATION Yaw dot dot computation from trajectory velocity in XY plane
%   Detailed explanation goes here

Jx = polyval(Jx_coef, t);
Jy = polyval(Jy_coef, t);
jerk_angle = atan2(Jy, Jx);

velocity_norm = Norm2D(Vx_coef,Vy_coef,t);
jerk_norm = Norm2D(Jx_coef,Jy_coef,t);

velocity_norm_prime = Norm2Dderivative(Vx_coef,...
                                       Vy_coef,...
                                       Ax_coef,...
                                       Ay_coef,...
                                       t);

yaw = YawComputation(Vx_coef,Vy_coef,t);
yaw_dot = YawDotComputation(Vx_coef,Vy_coef,Ax_coef,Ay_coef,t);

yaw_dot_dot = (jerk_norm * sin(jerk_angle - yaw) - ...
               2*velocity_norm_prime*yaw_dot)/velocity_norm;

end

