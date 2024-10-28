function w_d = compute_omega_d_T(entr)
    % Function: compute_omega_d_T
    % This function computes the desired angular velocity vector ω_d^T 
    % at a given time t based on the specified amplitude and frequency.
    %
    % Parameters:
    %   entr - A vector containing the following parameters:
    %          entr(1) = Amplitude of the angular velocity (a)
    %          entr(2) = Frequency of the angular velocity (nu)
    %          entr(3) = Time (t)
    %
    % Returns:
    %   w_d   - A 1x3 column vector containing the computed angular velocities:
    %           [sin(nu * t), cos(nu * t), sin(2 * nu * t)] scaled by the amplitude.

    % Extract parameters from the input vector
    a  = entr(1);  % Amplitude of the angular velocity
    nu = entr(2);  % Frequency of the angular velocity
    t  = entr(3);  % Time

    % Compute each component of the angular velocity vector
    % The resulting vector is scaled by the amplitude 'a' and transposed to a column vector.
    w_d = a * [sin(nu * t), cos(nu * t), sin(2 * nu * t)]';  % Compute desired angular velocity vector
end