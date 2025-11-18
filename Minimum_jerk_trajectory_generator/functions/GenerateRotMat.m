function R = GenerateRotMat(phi, theta, psi)
%GENERATEROTMAT Rotation matrix deriving from a 321 rotation sequence
%   roll - phi
%   pitch - theta
%   psi - psi

R = [cos(psi)*cos(theta) -cos(phi)*sin(psi) + cos(psi)*sin(theta)*sin(phi)  cos(psi)*cos(phi)*sin(theta) + sin(psi)*sin(phi);
     cos(theta)*sin(psi)  cos(psi)*cos(phi) + sin(psi)*sin(theta)*sin(phi) -cos(psi)*sin(phi) + cos(phi)*sin(psi)*sin(theta);
             -sin(theta)                               cos(theta)*sin(phi)                               cos(theta)*cos(phi)];  




end

