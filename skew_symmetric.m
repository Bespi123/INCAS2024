function S = skew_symmetric(omega)
    % Compute the skew-symmetric matrix for a given 3x1 vector.
    %
    % Parameters:
    % omega : A 1x3 or 3x1 vector [ω1, ω2, ω3]
    %
    % Returns:
    % S : A 3x3 skew-symmetric matrix

    % Ensure the input vector is a column vector
    if size(omega, 2) > 1
        omega = omega';
    end

    % Decompose the vector into components
    omega1 = omega(1);
    omega2 = omega(2);
    omega3 = omega(3);

    % Construct the skew-symmetric matrix
    S = [
                 0, -omega3,   omega2;
            omega3,       0,  -omega1;
           -omega2,  omega1,        0
        ];
end
