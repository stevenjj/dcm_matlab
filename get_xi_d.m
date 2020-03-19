function xi_d = get_xi_d(t, t_step, b, r_vrp, xi_eos)
    xi_d = r_vrp + exp((1/b)*(t-t_step)).*(xi_eos - r_vrp);
end
