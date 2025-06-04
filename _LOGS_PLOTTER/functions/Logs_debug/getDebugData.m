function debug = getDebugData(DebugDataMatrix)
%GETDEBUGDATA Get the logs_debug log data and compute derived values

    debug.time = DebugDataMatrix(:, 2);
    debug.xerr = DebugDataMatrix(:, 3:139);
    debug.outer_loop.K_hat_x_dot = DebugDataMatrix(:, 140:157);
    debug.outer_loop.K_hat_r_dot = DebugDataMatrix(:, 158:166);
    debug.outer_loop.Theta_hat_dot = DebugDataMatrix(:, 167:184);
    debug.outer_loop.K_hat_g_dot = DebugDataMatrix(:, 185:202);
    debug.inner_loop.K_hat_x_dot = DebugDataMatrix(:, 203:211);
    debug.inner_loop.K_hat_r_dot = DebugDataMatrix(:, 212:220);
    debug.inner_loop.Theta_hat_dot = DebugDataMatrix(:, 221:238);
    debug.inner_loop.K_hat_g_dot = DebugDataMatrix(:, 239:247);


end

