function h_dot = estimator(entr)
    % Function: estimator
    % This function computes the time derivative of the state estimate based on the 
    % difference between the current angular velocity and the desired angular velocity.
    %
    % Inputs:
    %   entr - A vector containing the following parameters:
    %          entr(1) = Gain factor (gamma)
    %          entr(2:4) = Current angular velocity vector (w) [wx, wy, wz]
    %          entr(5:7) = Desired angular velocity vector (wd) [wdx, wdy, wdz]
    %          entr(8:10) = Derivative of the desired angular velocity vector (wd_dot)
    %
    % Outputs:
    %   h_dot - The time derivative of the state estimate.

    gamma = entr(1);                             % Gain factor
    w     = [entr(2), entr(3), entr(4)]';       % Current angular velocity vector
    wd    = [entr(5), entr(6), entr(7)]';       % Desired angular velocity vector
    wd_dot = [entr(8), entr(9), entr(10)]';     % Derivative of the desired angular velocity

    % Compute the Omega matrix for wd_dot and the skew-symmetric matrix for w
    Y = compute_Omega(wd_dot) + skew_symmetric(w) * compute_Omega(w);

    % Calculate the derivative of the state estimate
    h_dot = -gamma * Y' * (w - wd);              % State estimate derivative based on error
end

function Omega = compute_Omega(omega)
    % Function: compute_Omega
    % This function computes the Omega matrix based on the angular velocity vector.
    %
    % Parameters:
    %   omega : A 1x3 vector containing the angular velocities [ω1, ω2, ω3]
    %
    % Returns:
    %   Omega : A 3x6 matrix representing the angular velocities in a specific format.

    % Decompose the angular velocity vector into individual components
    omega1 = omega(1);
    omega2 = omega(2);
    omega3 = omega(3);

    % Construct the Omega matrix based on the angular velocity components
    Omega = [
        omega1, 0,      0,      omega2, omega3, 0;
        0,      omega2, 0,      omega1, 0,      omega3;
        0,      0,      omega3, 0,      omega1, omega2
    ];
end