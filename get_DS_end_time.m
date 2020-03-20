function t_ds_end = get_DS_end_time(step_index, t_step, t_ds_vec, alpha)
    t_ds_start = get_DS_start_time(step_index, t_step, t_ds_vec, alpha);
    t_ds_end = t_ds_start + t_ds_vec(step_index);
end