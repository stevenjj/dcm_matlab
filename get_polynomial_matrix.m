function P = get_polynomial_matrix(Ts, xi_ini, xi_ini_vel, xi_end, xi_end_vel)
Pmat = zeros(4,4);
boundMat = [xi_ini'; xi_ini_vel'; xi_end'; xi_end_vel'];
Pmat(1, :) = [2.0/(Ts^3), 1/(Ts^2), -2/(Ts^3), 1/(Ts^2) ];
Pmat(2, :) = [-3.0/(Ts^2), -2.0/(Ts), 3/(Ts^2), -1/(Ts) ];
Pmat(3, :) = [0, 1, 0, 0];
Pmat(4, :) = [1, 0, 0, 0];
P = Pmat*boundMat;
end