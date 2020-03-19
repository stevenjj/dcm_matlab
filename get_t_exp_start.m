function t_local_start = get_t_exp_start(step_index, t_step)
    t_local_start = 0.0;
    for(i = 1:step_index)
        if (i < step_index)
            t_local_start = t_local_start + t_step(i);
        else
            break
        end
    end
end