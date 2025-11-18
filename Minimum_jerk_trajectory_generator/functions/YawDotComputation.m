function yaw_dot = YawDotComputation(Vx_coef,Vy_coef,Ax_coef,Ay_coef,t)
%YAWDOTCOMPUTATION Yaw dot computation from trajectory velocity in XY plane
%   Detailed explanation goes here

Ax = polyval(Ax_coef, t);
Ay = polyval(Ay_coef, t);
acceleration_angle = atan2(Ay, Ax);

velocity_norm = Norm2D(Vx_coef,Vy_coef,t);
acceleration_norm = Norm2D(Ax_coef,Ay_coef,t);

yaw = YawComputation(Vx_coef,Vy_coef,t);

yaw_dot = (acceleration_norm/velocity_norm)*sin(acceleration_angle - yaw);

end

