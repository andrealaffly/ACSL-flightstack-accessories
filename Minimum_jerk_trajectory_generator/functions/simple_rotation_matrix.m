function R_simple = simple_rotation_matrix(angle,axis)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simple_rotation_matrix computes the rotation matrix R_simple associated
% to a simple rotation. The axis of rotation is captured by the character
% 'axis'. The rotation angle is captured by 'angle'. 
%
% Examples: 
%     angle = pi/4;
%     axis = '1'
%     R_simple = simple_rotation_matrix(angle,axis)
% 
%     angle = sym('theta','real');
%     axis = '2'
%     R_simple = simple_rotation_matrix(angle,axis)
% 
%     angle = pi/7;
%     axis = '3'
%     R_simple = simple_rotation_matrix(angle,axis)
% 
%
% Dr. Andrea L'Afflitto
% Virginia Tech
% ISE 4264 -- Industrial Automation
% 01/29/2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if axis ~= ['1','2','3']          % Check that sequence contains 3 elements only
    msg = 'The input axis must be equal to the character 1, 2, or 3';
    error(msg)
else
    switch axis
        case '1'
            R_simple = [1,0,0;0,cos(angle),-sin(angle);0,sin(angle),cos(angle)];
        case '2'
            R_simple = [cos(angle), 0, sin(angle);0, 1, 0; -sin(angle), 0, cos(angle)];
        case '3'
            R_simple = [cos(angle), -sin(angle), 0; sin(angle), cos(angle), 0;0, 0, 1];
    end
end
 