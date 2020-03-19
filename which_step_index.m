function step_index = which_step_index(t_input, t_step)
% Get trajectory length and clamp t_input within the trajectory bounds
t_trajectory_length = get_trajectory_length(t_step);
t_input = max(min(t_input, t_trajectory_length), 0.0);

t_step_start = 0.0;
step_index = 1;
for(i = 1:size(t_step,2))
    t_step_end = t_step_start + t_step(i);
    if (t_step_start <= t_input) && (t_input < t_step_end)
       step_index = i;
       return
    end
    t_step_start = t_step_end;
end

step_index = size(t_step, 2);