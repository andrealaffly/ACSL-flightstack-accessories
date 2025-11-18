function yaw = YawComputation(Vx_coef,Vy_coef,t)
%YAWCOMPUTATION Yaw computation from trajectory velocity in XY plane
%   Detailed explanation goes here

Vx = polyval(Vx_coef, t);
Vy = polyval(Vy_coef, t);

yaw = atan2(Vy, Vx);

end

