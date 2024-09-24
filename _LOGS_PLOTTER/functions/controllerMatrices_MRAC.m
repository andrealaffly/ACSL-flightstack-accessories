function controller_matrices = controllerMatrices_MRAC(vp, gains)

  % Initialize to zero the 6x6 matrix and set the top-right 3x3 block as follows
  controller_matrices.A_translational = zeros(6, 6);
  controller_matrices.A_translational(1:3, 4:6) = eye(3);
  
  % Initialize to zero the 6x3 matrix and set the bottom 3x3 block as follows
  controller_matrices.B_translational = zeros(6, 3);
  controller_matrices.B_translational(4:6, 1:3) = eye(3);
  
  % Initialize to zero the 6x6 matrix 
  controller_matrices.A_ref_translational = zeros(6, 6);
  % Set the top-right 3x3 block as follows
  controller_matrices.A_ref_translational(1:3, 4:6) = eye(3);
  % Set the bottom-left 3x3 block as follows
  controller_matrices.A_ref_translational(4:6, 1:3) = -gains.BASELINE.KP_refmod_translational;
  % Set the bottom-right 3x3 block as follows
  controller_matrices.A_ref_translational(4:6, 4:6) = -gains.BASELINE.KD_refmod_translational;
  
  % Initialize to zero the 6x3 matrix and set the bottom 3x3 block as follows
  controller_matrices.B_ref_translational = zeros(6, 3);
  controller_matrices.B_ref_translational(4:6, 1:3) = (1 / vp.mass) * eye(3);
  
  % Initialize to zero the 3x3 matrix 
  controller_matrices.A_rotational = zeros(3, 3);
  
  % Set the 3x3 matrix as follows
  controller_matrices.B_rotational = eye(3);
  
  % Set the 3x3 matrix as follows
  controller_matrices.A_ref_rotational = -gains.BASELINE.KP_omega_ref_rotational;
  
  % Set the 3x3 matrix as follows
  controller_matrices.B_ref_rotational = eye(3);
  
  % Solve the continuous Lyapunov equation to compute P_translational
  controller_matrices.P_translational = lyap(controller_matrices.A_ref_translational', gains.ADAPTIVE.Q_translational);
  
  % Solve the continuous Lyapunov equation to compute P_rotational
  controller_matrices.P_rotational = lyap(controller_matrices.A_ref_rotational', gains.ADAPTIVE.Q_rotational);




end

