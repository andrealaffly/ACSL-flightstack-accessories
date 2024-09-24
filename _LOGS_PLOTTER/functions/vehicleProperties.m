function vp = vehicleProperties()
%VEHICLE_PROPERTIES X8Copter

% Mass
vp.mass = 1.92;

% Inertia matrix
vp.inertia_mat = [ 2.271990e-02, -6.557000e-06, -1.003498e-03;
                  -6.557000e-06,  2.202047e-02,  5.658400e-06;
                  -1.003498e-03,  5.658400e-06,  1.614693e-02];

end

