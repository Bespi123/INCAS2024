function u = controller(entr)
    % Function: controller
    % This function computes the control input based on the desired and current angular velocities,
    % along with the desired acceleration and state estimation.
    %
    % Inputs:
    %   entr - A vector containing the following parameters:
    %          entr(1:3)  = Desired angular acceleration vector (wd_dot) [wdot_x, wdot_y, wdot_z]
    %          entr(4:6)  = Desired angular velocity vector (wd) [wd_x, wd_y, wd_z]
    %          entr(7:9)  = Current angular velocity vector (w) [w_x, w_y, w_z]
    %          entr(10:12) = Diagonal elements for the gain matrix (Gamma) [g1, g2, g3]
    %          entr(13:18) = State estimate errors (h_tilde) [h1_tilde, h2_tilde, h3_tilde, h4_tilde, h5_tilde, h6_tilde]
    %
    % Outputs:
    %   u - The control input vector to the system.

    % Extract input parameters
    wd_dot = [entr(1), entr(2), entr(3)]';  % Desired angular acceleration
    wd     = [entr(4), entr(5), entr(6)]';  % Desired angular velocity
    w      = [entr(7), entr(8), entr(9)]';  % Current angular velocity
    Gamma  = diag([entr(10), entr(11), entr(12)]);  % Diagonal gain matrix
    h_tilde = [entr(13), entr(14), entr(15), ...
               entr(16), entr(17), entr(18)]';  % State estimate errors

    % Calculate the error in angular velocity
    w_tilde = w - wd;  % Error between current and desired angular velocities

    % Calculate the control input based on the dynamics
    Y = compute_Omega(wd_dot) + skew_symmetric(w) * compute_Omega(w);  % Combined dynamics
    u = Y * h_tilde - Gamma * w_tilde;  % Control input calculation

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