function u = controller(entr)
%%%Inputs
wd_dot = [entr(1),entr(2),entr(3)]';
wd     = [entr(4),entr(5),entr(6)]';
w      = [entr(7),entr(8),entr(9)]';
Gamma  = diag([entr(10),entr(11),entr(12)]);
h_tilde = [entr(13),entr(14),entr(15),...
           entr(16),entr(17),entr(18)]';
%%%Calculate w_tilde
w_tilde = w-wd;

Y = compute_Omega(wd_dot)+skew_symmetric(wd)*compute_Omega(w);
u = Y*h_tilde-Gamma*w_tilde;


end

function Omega = compute_Omega(omega)
    % Compute the Omega matrix based on the angular velocity vector.
    %
    % Parameters:
    % omega : A 1x3 vector containing the angular velocities [ω1, ω2, ω3]
    %
    % Returns:
    % Omega : A 3x6 matrix

    % Decompose the angular velocity vector
    omega1 = omega(1);
    omega2 = omega(2);
    omega3 = omega(3);

    % Construct the Omega matrix
    Omega = [
        omega1, 0,      0,      omega2, omega3, 0;
        0,      omega2, 0,      omega1, 0,      omega3;
        0,      0,      omega3, 0,      omega1, omega2
    ];
end

