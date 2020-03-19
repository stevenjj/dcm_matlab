function xi_vel_d = get_xi_vel_d(t, t_step, b, r_vrp, xi_eos)
    xi_vel_d = (1/b)*exp((1/b)*(t-t_step)).*(xi_eos - r_vrp);
end
