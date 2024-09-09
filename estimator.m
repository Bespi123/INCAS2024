function h_dot = estimator(entr)
gamma = entr(1);
w     = [entr(2),entr(3),entr(4)]';
wd    = [entr(5),entr(6),entr(7)]';
wd_dot = [entr(8),entr(9),entr(10)]';

Y = compute_Omega(wd_dot)+skew_symmetric(wd)*compute_Omega(w);
h_dot = -gamma*Y'*(w-wd);

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

