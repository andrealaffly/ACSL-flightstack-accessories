function R = matrix_generator(sequence)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% matrix_generator finds the rotation matrix R given by the 'sequence' of
% simple rotations. 'sequence' must be a string of characters containing
% 3, 2, or 1 only.
%
% Example: 
%     sequence = '32132'; 
%     R = matrix_generator(sequence)
% 
%     sequence = '22'; 
%     R = matrix_generator(sequence)
% 
%     sequence = '323'; 
%     R = matrix_generator(sequence)

% Dr. Andrea L'Afflitto
% Virginia Tech
% ISE 4264 -- Industrial Automation
% 01/29/2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if  ~ismember(['1','2','3'],sequence)          % Check that sequence contains '1', '2', or '3' only
    msg = 'Sequence must contain 1, 2, or 3 only';
    error(msg)
else
    R = eye(3);
    alpha = sym('alpha',[length(sequence),1],'real');

    for jj = 1:length(sequence)
        R_temp = simple_rotation_matrix(alpha(jj),sequence(jj));
        R = R*R_temp;
    end

    R = simplify(R); 
end