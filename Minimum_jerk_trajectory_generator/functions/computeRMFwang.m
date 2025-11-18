%=========================================================================
% Code to generate Rotation Minimizing Frames
% Author: Jyotirmoy Mukherjee
% ACSL, TMVS Laboratory
% Email: jmukherjee@vt.edu
% Readme: The code takes in the spline objects and the vector of spline
% parameters. It returns a matrix of size 3x3 using a double reflection 
% algorithm where the first column represents the vehicle roll axis, 
% the second column represents the approximate vehicle pitch axis and
% the third column represents the approximate vehicle yaw axis. 
% Together, they are the Rotation Minimizing Frames
%=========================================================================


function [R] = computeRMFwang(s, spline_x, spline_y, spline_z)
    % Initialization
    numPoints = length(s);
    R = zeros(3, 3, numPoints); % Rotation matrices along the spline
    
    % Compute the initial Frenet frame
    [T0, N0, B0] = computeFrenetFrame(s(1), spline_x, spline_y, spline_z);
     
    R(:,:,1) = [T0, N0, B0];

    ri=B0;
    si=N0;
    ti=T0;
    
    for i = 2:numPoints
        % Compute the tangent vector at s(i)
       
        x_ip1=[ppval(spline_x,s(i));
               ppval(spline_y,s(i));
               ppval(spline_z,s(i))];

        x_i=[ppval(spline_x,s(i-1));
            ppval(spline_y,s(i-1));
            ppval(spline_z,s(i-1))];

        v1=x_ip1-x_i;
        c1=dot(v1,v1);
        ri_L=ri-(2/c1)*(dot(v1,ri))*v1;
        ti_L=ti-(2/c1)*(dot(v1,ti))*v1;
         
        [ti_p1,~,~]=computeFrenetFrame(s(i), spline_x, spline_y, spline_z);
       

        v2=ti_p1-ti_L;
        c2=dot(v2,v2);
        ri_p1=ri_L-(2/c2)*dot(v2,ri_L)*v2;
        si_p1=cross(ri_p1,ti_p1);

        R(:,1,i)=ti_p1;
        R(:,2,i)=si_p1;
        R(:,3,i)=ri_p1;

        ti=ti_p1;
        si=si_p1;
        ri=ri_p1;


  
    end
end