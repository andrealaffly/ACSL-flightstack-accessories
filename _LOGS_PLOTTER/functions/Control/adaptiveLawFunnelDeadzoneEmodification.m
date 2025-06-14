function K_hat_state_dot = adaptiveLawFunnelDeadzoneEmodification( ...
  Gamma_gain, ...
  dead_zone_value, ...
  pi_vector, ...
  tracking_error, ...
  P_mat, ...
  B_mat, ...
  sigma_gain, ...
  K_hat_state, ...
  H_funnel, ...
  Ve_funnel, ...
  M_funnel)
%ADAPTIVELAWFUNNELDEADZONEEMODIFICATION Adaptive law for Funnel MRAC equipped with dead-zone
%modification and e-modification

eTranspose_P_B_funnel = (tracking_error' * (P_mat + M_funnel * Ve_funnel) * B_mat) / H_funnel;

K_hat_state_dot = Gamma_gain * dead_zone_value * ( ...
  pi_vector * eTranspose_P_B_funnel ...
  - sigma_gain * norm(eTranspose_P_B_funnel) * K_hat_state);


end

