function xi_ref_d = get_xi_ref_d(t, t_step, b, r_vrp, xi_eos)
    xi_ref_d = zeros(3, size(t,2));
    t_local_start = 0.0;
    for(i = 1:size(xi_ref_d,2))
        step_index = which_step_index(t(i), t_step);
        t_local_start = get_t_exp_start(step_index, t_step);
        xi_ref_d(:, i) = get_xi_d(t(i) - t_local_start, t_step(step_index), b, r_vrp(:, step_index), xi_eos(:, step_index));
    end
end
