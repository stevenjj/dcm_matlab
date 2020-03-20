function r_vrp_traj = compute_rvrp_given_dcm(b, xi, xi_vel)
    r_vrp_traj = xi - b*xi_vel;
end