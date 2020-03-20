function t_ds_start = get_DS_start_time(step_index, t_step, t_ds_vec, alpha)
    t_ds_start = get_t_exp_start(step_index, t_step);
    if (step_index > 1)
        t_ds_start = t_ds_start - alpha*t_ds_vec(step_index);
    end
end