function xi_DS_poly = get_xi_DS_poly(t, Ts, P_mat)
    xi_DS_poly = zeros(3, size(t,2));
    
    % Clamp input to boundary Ts
    for (i = 1:size(t,2))
        t_input = max(min(t(i), Ts), 0.0);
        time_vec = [t_input^3, t_input^2, t_input, 1];
        xi_DS_poly(:,i) = time_vec*P_mat;
    end
end