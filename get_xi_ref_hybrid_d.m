function xi_ref_hybrid_d = get_xi_ref_hybrid_d(t, t_step, b, r_vrp, xi_eos, t_ds_vec, alpha, P_mats)
xi_ref_hybrid_d = zeros(3, size(t,2));
    t_local_start = 0.0;
    for(i = 1:size(xi_ref_hybrid_d,2))
        % Identify which step index to use
        step_index = which_hybrid_step_index(t(i), t_step, t_ds_vec, alpha);
        % Use Polynomial Interpolation
        if (t(i) <= get_DS_end_time(step_index, t_step, t_ds_vec, alpha))
            t_local_start = t(i) - get_DS_start_time(step_index, t_step, t_ds_vec, alpha);
            xi_ref_hybrid_d(:, i) = get_xi_DS_poly(t_local_start, t_ds_vec(step_index), P_mats(:,:, step_index));
        % Use exponential interpolation
        else
            t_local_start = t(i) - get_t_exp_start(step_index, t_step);
            xi_ref_hybrid_d(:, i) = get_xi_d(t_local_start, t_step(step_index), b, r_vrp(:, step_index), xi_eos(:, step_index));
        end
    end
end
