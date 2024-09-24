
init_timestamp = 1;
t = log.time(init_timestamp:end);

Pos_y_integrated = cumtrapz(log.user_defined_velocity.y(init_timestamp:end))*0.01;

Pos_y_ref_integrated = cumtrapz(log.outer_loop.reference_model.position.y(init_timestamp:end))*0.01;

plot(t, Pos_y_integrated,  '--',LineWidth=2)
hold on
plot(log.time, log.user_defined_position.y,LineWidth=1.5)
plot(t, Pos_y_ref_integrated,  '--',LineWidth=2)
plot(log.time, log.outer_loop.reference_model.position.y,LineWidth=1.5)
legend('Pos y integrated', 'log.user defined position.y', 'Pos y ref integrated', 'log.outer loop.reference model.position.y')