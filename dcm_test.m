clc; clear;
% Set Walking Params
g = 9.81;
z = 0.75;
b = sqrt(z/g);

% Temporal Parameters
t_transfer = 0.1;
t_ss = 0.3;
t_ds = 0.05;
alpha = 0.5;
t_ds_ini = alpha*t_ds;
t_ds_end = (1-alpha)*t_ds;

% Initialize foot conditions
rfoot_y = -0.33;
lfoot_y = 0.0;
midfeet_y = (lfoot_y +rfoot_y)/2.0;

% Initial dcm_state
xi_init_state = [0.0; midfeet_y; z];
xi_vel_init_state = [0.0; 0.0; 0.0];

% Initialize DCM containers
r_vrp = zeros(3,4);
n = size(r_vrp, 2);
t_step = zeros(1, n);
xi_ini = zeros(3, n);
xi_eos = zeros(3, n);

% Initialize r_vrp 
r_vrp(:,1) = [0, midfeet_y, z];
r_vrp(:,2) = [0, lfoot_y, z];
r_vrp(:,3) = [1, rfoot_y,  z];
r_vrp(:,4) = [1, midfeet_y, z];
% Initialize t_step
t_step(:,1) = t_transfer + t_ds;
t_step(:,2) = t_ss + t_ds;
t_step(:,3) = t_ss + t_ds + (1-alpha)*t_ds;
t_step(:,4) = 0.0;

% Polynomial Vectors
xi_ini_DS = zeros(3, n);
xi_ini_vel_DS = zeros(3, n);
xi_end_DS = zeros(3, n);
xi_end_vel_DS = zeros(3, n);
t_ds_vec = ones(1,n)*t_ds;
t_ds_vec(1) = t_transfer + t_ds + (1-alpha)*t_ds;
P_mats = zeros(4,3,n);

% Recursively find xi boundary conditions
xi_eos(:,end) = r_vrp(:,end);
for(j = 1:n)
    i = n-j+1; % Reverse counter
    xi_ini(:,i) = r_vrp(:,i) + exp( -(1/b)*t_step(i) ) * (xi_eos(:,i) - r_vrp(:,i));
    if (i > 1)
        xi_eos(:,i-1) = xi_ini(:,i);
    end
end

% Define double support boundary conditions
% Initial Double Support Conditions
xi_ini_DS(:,1) = xi_init_state;
xi_ini_vel_DS(:,1) = xi_vel_init_state;
for(j = 1:n)
    i = n-j+1; % Reverse counter
    if (i > 1)
        xi_ini_DS(:,i) = r_vrp(:,i-1) + exp((-1/b)*t_ds_ini)*(xi_ini(:,i) - r_vrp(:,i-1));        
        xi_ini_vel_DS(:,i) = (1/b)*exp((-1/b)*t_ds_ini)*(xi_ini(:,i) - r_vrp(:,i-1));        
    end
end

% Ending Double Support conditions
for(i = 1:n)
    xi_end_DS(:,i) = r_vrp(:,i) + exp((1/b)*t_ds_end)*(xi_ini(:,i) - r_vrp(:,i));
    xi_end_vel_DS(:,i) = (1/b)*exp((1/b)*t_ds_end)*(xi_ini(:,i) - r_vrp(:,i));
end
xi_end_DS(:,1) = xi_end_DS(:,2);
xi_end_vel_DS(:,1) = xi_end_DS(:,2);

% Compute Polynomial Matrices
for (i = 1:n)
    P_mats(:,:,i) = get_polynomial_matrix(t_ds_vec(i), xi_ini_DS(:,i), xi_ini_vel_DS(:,i), xi_end_DS(:,i), xi_end_vel_DS(:,i));
end

% Get DCM references ------------------------------------------------------
t = [0:0.005:1];
% Exponential DCM references
xi_ref_d = get_xi_ref_d(t, t_step, b, r_vrp, xi_eos);
xi_vel_ref_d = get_xi_vel_ref_d(t, t_step, b, r_vrp, xi_eos);

% Set index to plot
figure(1)
hold on
scatter(t, xi_ref_d(1,:))
scatter(t, xi_vel_ref_d(1,:));
t_start = 0.0;
for(i = 1:size(t_step,2))
    xline(t_start);
    t_start = t_start + t_step(i);
end
xlabel('time(s)')
ylabel('dcm')
legend({'DCM x','DCM x vel'},'Location','northeast')

figure(2)
hold on
t_start = 0.0;
scatter(t, xi_ref_d(2,:))
scatter(t, xi_vel_ref_d(2,:));
for(i = 1:size(t_step,2))
    xline(t_start);
    t_start = t_start + t_step(i);
end
xlabel('time(s)')
ylabel('dcm')
legend({'DCM y','DCM y vel'},'Location','northeast')

figure(3)
hold on
t_start = 0.0;
scatter(t, xi_ref_d(3,:))
scatter(t, xi_vel_ref_d(3,:));
for(i = 1:size(t_step,2))
    xline(t_start);
    t_start = t_start + t_step(i);
end
xlabel('time(s)')
ylabel('dcm')
legend({'DCM z','DCM z vel'},'Location','northeast')

%---
figure(4)
index_to_try = n;
xi_vel_ds_poly_test = get_xi_vel_DS_poly(t, t_ds_vec(index_to_try), P_mats(:,:, index_to_try));
plot(t, xi_vel_ds_poly_test(2,:))
