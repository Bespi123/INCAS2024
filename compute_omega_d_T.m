function w_d = compute_omega_d_T(entr)
    a  = entr(1);
    nu = entr(2);
    t  = entr(3);
    % Compute the desired angular velocity vector ω_d^T at a given time t.
    %
    % Parameters:
    % a  : Amplitude of the angular velocity
    % nu : Frequency of the angular velocity
    % t  : Time
    %
    % Returns:
    % omega_d_T : A 1x3 row vector [sin(nu * t), cos(nu * t), sin(2 * nu * t)]

    % Compute each component of the angular velocity
    w_d = a * [sin(nu * t), cos(nu * t), sin(2 * nu * t)]';
end