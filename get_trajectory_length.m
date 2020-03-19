function t_traj_length = get_trajectory_length(t_step)
t_traj_length = 0.0;
for(i = 1:size(t_step,2))
    t_traj_length = t_traj_length + t_step(i);
end