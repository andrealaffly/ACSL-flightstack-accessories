%=========================================================================
% Code to generate Frenet Serret Frames
% Author: Jyotirmoy Mukherjee
% ACSL, TMVS Laboratory
% Email: jmukherjee@vt.edu
% Readme: The code takes in the spline objects and the vector of spline
% parameters. It returns a matrix of size 3x3 where the first column
% represents the tangent vector, the second column represents the normal
% vector and the third column represents the binormal vector - together
% they make the Frenet Serret Frames
%=========================================================================


function [T, N, B] = computeFrenetFrame(s, spline_x, spline_y, spline_z)
    % Compute the first derivative (tangent vector)
    dx = ppval(fnder(spline_x), s);
    dy = ppval(fnder(spline_y), s);
    dz = ppval(fnder(spline_z), s);
    
    T = [dx; dy; dz];
 
    % Compute the second derivative
    ddx = ppval(fnder(spline_x, 2), s);
    ddy = ppval(fnder(spline_y, 2), s);
    ddz = ppval(fnder(spline_z, 2), s);
    
    % Compute the normal vector
    N = [ddx; ddy; ddz];%;- dot([ddx; ddy; ddz], T) * T;
    N = N / norm(N); % Normalize
    
    % Compute the binormal vector
    B = cross(T, N);
    
end