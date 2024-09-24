function mocap = getMocapData(MocapDataMatrix)
%GETMOCAPDATA Get the MOCAP log data and compute derived values

    mocap.time = MocapDataMatrix(:, 2);
    mocap.position.x = MocapDataMatrix(:, 3);
    mocap.position.y = MocapDataMatrix(:, 4);
    mocap.position.z = MocapDataMatrix(:, 5);
    mocap.quaternion.q0 = MocapDataMatrix(:, 6);
    mocap.quaternion.q1 = MocapDataMatrix(:, 7);
    mocap.quaternion.q2 = MocapDataMatrix(:, 8);
    mocap.quaternion.q3 = MocapDataMatrix(:, 9);
    mocap.velocity.x = MocapDataMatrix(:, 10);
    mocap.velocity.y = MocapDataMatrix(:, 11);
    mocap.velocity.z = MocapDataMatrix(:, 12);
    mocap.angular_velocity.x = MocapDataMatrix(:, 13);
    mocap.angular_velocity.y = MocapDataMatrix(:, 14);
    mocap.angular_velocity.z = MocapDataMatrix(:, 15);

    % Create a quaternion array
    mocap.quaternion.quat = quaternion(mocap.quaternion.q0, ...
                                       mocap.quaternion.q1, ...
                                       mocap.quaternion.q2, ...
                                       mocap.quaternion.q3);

    % Specify the sequence for conversion to Euler angles
    mocap.quaternion.sequence = 'ZYX';

    % Convert quaternion array to Euler angles
    mocap.quaternion.eulerAnglesFromQuat = quat2eul(mocap.quaternion.quat, ...
                                                    mocap.quaternion.sequence);

    mocap.euler_angles.roll = mocap.quaternion.eulerAnglesFromQuat(:, 3);
    mocap.euler_angles.pitch = mocap.quaternion.eulerAnglesFromQuat(:, 2);
    mocap.euler_angles.yaw = mocap.quaternion.eulerAnglesFromQuat(:, 1);
end

