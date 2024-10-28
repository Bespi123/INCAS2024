function dx = BrushelessModel_simu(entr)
    % Function: BrushelessModel_simu
    % This function simulates the dynamics of a brushless motor.
    %
    % Inputs:
    %   entr - A vector containing the following parameters:
    %          entr(1) = Reaction wheel angular rate (w) in rad/s
    %          entr(2) = Reaction wheel current (i) in A
    %          entr(3) = Input voltage (Vpwm), average voltage applied to the motor
    %          entr(4) = Torque constant (kt) in N*m/A
    %          entr(5) = Rotor inertia (J) in kg*m^2
    %          entr(6) = Viscous friction constant (B) in N*m*s
    %          entr(7) = Coulomb friction constant (Kc) in N*m
    %          entr(8) = Inductance (L) in H
    %          entr(9) = Resistance (R) in Ω
    %          entr(10) = Back EMF constant (Ke) in V/(rad/s)
    %
    % Outputs:
    %   dx - A vector containing the derivatives of the state variables:
    %        dx(1) = Angular acceleration (w_dot) in rad/s^2
    %        dx(2) = Rate of change of current (i_dot) in A/s

    % Extract state variables and parameters from the input vector
    w = entr(1);   % Reaction wheel angular rate
    i = entr(2);   % Reaction wheel current
    u = entr(3);   % Input voltage (Vpwm)
    kt = entr(4);  % Torque constant
    J = entr(5);   % Rotor inertia
    B = entr(6);   % Viscous friction constant
    Kc = entr(7);  % Coulomb friction constant
    L = entr(8);   % Inductance
    R = entr(9);   % Resistance
    Ke = entr(10); % Back EMF constant

    % Calculate the derivatives of the state variables
    % w_dot: Angular acceleration of the motor
    % The equation includes the torque produced, viscous friction, and Coulomb friction.
    w_dot = 1/J * (kt * i - B * w - Kc * sign(w));  % Angular acceleration equation

    % i_dot: Rate of change of current in the motor
    % This equation relates the input voltage, resistive losses, and back EMF.
    i_dot = 1/L * (u - R * i - Ke * w);  % Current change equation

    % Create a vector to hold the state derivatives
    dx = [w_dot; i_dot];  % Combine derivatives into a single vector
end