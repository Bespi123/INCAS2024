function [x_dot] = cubeSatEquationState(entr)
% Function: cubeSatEquationState
% This function computes the state equations for a CubeSat based on input
% disturbances, input torque, rigid body inertia, attitude quaternion,
% and angular rates.
%
% Author: Brayan Espinoza
%
% Inputs:
%   entr - A vector containing the following parameters:
%          entr(1) = Disturbance torque component (Td_x)
%          entr(2) = Disturbance torque component (Td_y)
%          entr(3) = Disturbance torque component (Td_z)
%          entr(4) = Inertia component (I_11)
%          entr(5) = Inertia component (I_22)
%          entr(6) = Inertia component (I_33)
%          entr(7) = Inertia coupling component (I_12 = I_21)
%          entr(8) = Inertia coupling component (I_13 = I_31)
%          entr(9) = Inertia coupling component (I_23 = I_32)
%          entr(10) = Input torque component (U_x)
%          entr(11) = Input torque component (U_y)
%          entr(12) = Input torque component (U_z)
%          entr(13) = Quaternion component (q1)
%          entr(14) = Quaternion component (q2)
%          entr(15) = Quaternion component (q3)
%          entr(16) = Quaternion component (q4)
%          entr(17) = Angular rate component (wx)
%          entr(18) = Angular rate component (wy)
%          entr(19) = Angular rate component (wz)
%
% Outputs:
%   x_dot - A vector containing the derivatives of the state variables:
%           [q_dot; w_dot], where:
%           q_dot = Derivative of the quaternion
%           w_dot = Derivative of the angular rates

    % Disturbance torque vector
    Td = [entr(1), entr(2), entr(3)]';  % Disturbances (3D vector)

    % Inertia matrix
    I = [entr(4), entr(7), entr(8);  % I_11, I_12, I_13
         entr(7), entr(5), entr(9);  % I_21, I_22, I_23
         entr(8), entr(9), entr(6)];  % I_31, I_32, I_33

    % Input torque vector
    U = [entr(10), entr(11), entr(12)]';  % Input torque (3D vector)

    % Quaternion state vector
    q = [entr(13), entr(14), entr(15), entr(16)]';  % Attitude quaternion

    % Angular rate vector
    w = [entr(17), entr(18), entr(19)]';  % Angular rates (wx, wy, wz)

    % Kinematics and Dynamics Equations
    % Book: Fundamentals of Spacecraft Attitude Determination and Control
    % Author: F. Landis Markley & John L. Crassidis

    % Quaternion kinematics matrix
    Xi = [-q(2), -q(3), -q(4);
           q(1), -q(4),  q(3);
           q(4),  q(1), -q(2);
          -q(3),  q(2),  q(1)]; 

    % Kinematic equation for quaternion derivative
    q_dot = 1/2 * Xi * w;  % Equation (2.88) from reference

    % Dynamics equation for angular rate derivative
    w_dot = I \ (Td + U - cross(w, I * w));  % Equation (3.147) from reference

    % State derivative vector
    x_dot = [q_dot; w_dot];  % Combine the derivatives into a single vector
end
