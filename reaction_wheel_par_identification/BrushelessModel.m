% Function: BrushelessModel
% This function models the dynamics of a brushless motor.
%
% Inputs:
%   t      - Current time (not used in this model but typically required for ODE solvers).
%   x      - State vector, where:
%             x(1) = Angular rate of the motor (w) in rad/s
%             x(2) = Current through the motor (i) in A
%   u      - Input voltage (Vpwm), the average voltage applied to the motor.
%   kt     - Torque constant (N*m/A), relating current to torque produced.
%   J      - Rotor inertia (kg*m^2), representing the motor's resistance to angular acceleration.
%   B      - Viscous friction constant (N*m*s), representing resistive torque due to friction.
%   Kc     - Coulomb friction constant (N*m), representing static friction.
%   L      - Inductance (H), representing the motor windings' inductance.
%   R      - Resistance (Ω), representing the electrical resistance of the windings.
%   Ke     - Back electromotive force (EMF) constant (V/(rad/s)), relating angular velocity to voltage.
%   varargin - Additional parameters (not used in the current function implementation).
%
% Outputs:
%   dx     - Derivative of the state vector (state change).
%   y      - Output vector, representing the angular rate and current.

function [dx, y] = BrushelessModel(t, x, u, kt, J, B, Kc, L, R, Ke, varargin)
    % Define state variables from the input state vector x
    w = x(1);  % Angular rate (rad/s)
    i = x(2);  % Motor current (A)

    % Calculate the derivatives of the state variables
    % w_dot: Angular acceleration of the motor
    % Here, we calculate the angular acceleration by considering the torque produced, 
    % viscous friction, and Coulomb friction.
    w_dot = 1/J * (kt * i - B * w - Kc * sign(w));  % Angular acceleration equation

    % i_dot: Rate of change of current in the motor
    % This equation relates the input voltage, resistive losses, and back EMF.
    i_dot = 1/L * (u - R * i - Ke * w);  % Current change equation

    % State derivative vector
    dx = [w_dot; i_dot];  % Combine derivatives into a single vector

    % Output vector
    % The output includes the current state variables: angular rate and current.
    y = [x(1);  % Output angular rate
         x(2)]; % Output current
end