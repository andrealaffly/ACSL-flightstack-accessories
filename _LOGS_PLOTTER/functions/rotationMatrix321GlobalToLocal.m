function rotation_matrix_321_global_to_local = rotationMatrix321GlobalToLocal(roll, pitch, yaw)
    % Define the transpose of R1
    R1_transpose = [
        1,  0,               0;
        0,  cos(roll),  sin(roll);
        0, -sin(roll),  cos(roll)
    ];

    % Define the transpose of R2
    R2_transpose = [
        cos(pitch),  0,  -sin(pitch);
        0,                1,   0;
        sin(pitch),  0,   cos(pitch)
    ];

    % Define the transpose of R3
    R3_transpose = [
        cos(yaw),  sin(yaw),  0;
       -sin(yaw),  cos(yaw),  0;
        0,              0,              1
    ];

    % Compute the rotation matrix 321 (Global to Local)
    rotation_matrix_321_global_to_local = R1_transpose * R2_transpose * R3_transpose;
end
