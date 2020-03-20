function step_index = which_hybrid_step_index(t_input, t_step, t_ds_vec, alpha)
% Get trajectory length and clamp t_input within the trajectory bounds
t_trajectory_length = get_trajectory_length(t_step);
t_input = max(min(t_input, t_trajectory_length), 0.0);

% Get which hybrid step index to use
for(i = 1:size(t_step,2))
    if (i < size(t_step,2))
        t_ds_step_start = get_DS_start_time(i, t_step, t_ds_vec, alpha);
        t_step_end = get_DS_start_time(i+1, t_step, t_ds_vec, alpha);
        if (t_ds_step_start <= t_input) && (t_input < t_step_end)
           step_index = i;
           return
        end
    else
        break
    end
end

step_index = size(t_step, 2);