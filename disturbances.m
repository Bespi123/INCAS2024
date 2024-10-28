function Td_body = disturbances(entr)
    % Function: disturbances
    % This function calculates the total disturbance torque acting on the CubeSat in its body frame.
    %
    % Inputs:
    %   entr - A vector containing the following parameters:
    %          entr(1:4) = Quaternion components (q) representing the CubeSat's orientation
    %          entr(5:7) = Angular rates (w) in the body frame (wx, wy, wz)
    %          entr(8:10) = Center of gravity offset (cg) in the body frame
    %          entr(11)   = Air friction coefficient (alpha)
    %          entr(12:14) = Miscellaneous torques in the inertial frame
    %          entr(15)   = Mass of the satellite (m_sat)
    %
    % Outputs:
    %   Td_body - A 3D vector representing the total disturbance torque in the body frame.

    % Extract quaternion and angular rate components from input vector
    q  = [entr(1), entr(2), entr(3), entr(4)]';  % Quaternion representing orientation
    w  = [entr(5), entr(6), entr(7)]';            % Angular rates in the body frame
    cg = [entr(8), entr(9), entr(10)]';           % Center of gravity offset
    alpha = entr(11);                             % Air friction coefficient
    mis_inertial_Frame = [entr(12), entr(13), entr(14)]';  % Miscellaneous torques in inertial frame
    m_sat = entr(15);                             % Mass of the satellite

    %% Calculate disturbances in the body frame
    % Get angular rates in the inertial frame
    w_inertia = quatRotation(q, w);               % Rotate angular rates to inertial frame
    T_air_inertia = [0, 0, alpha * w_inertia(3)]';  % Air disturbance torque in the inertial frame
    T_air_body = quatRotation(quatconj(q'), T_air_inertia);  % Convert air disturbance torque to body frame

    % Compute gravity torque disturbance
    T_gg_body  = T_disturbances(m_sat, cg, q);  % Gravity disturbance torque in body frame

    % Convert miscellaneous torques from inertial frame to body frame
    mis_body_Frame = quatRotation(quatconj(q'), mis_inertial_Frame);

    % Total disturbance torque in the body frame
    Td_body = T_gg_body - T_air_body + mis_body_Frame; 
end

function [Tgg] = T_disturbances(Ms, R_cm, q)
    % Function: T_disturbances
    % This function calculates the gravitational disturbance torque acting on the CubeSat.
    %
    % Inputs:
    %   Ms    - Mass of the satellite
    %   R_cm  - Center of mass offset vector in the body frame
    %   q     - Quaternion representing the CubeSat's orientation
    %
    % Outputs:
    %   Tgg   - Gravitational disturbance torque in the body frame

    g_inertial = [0, 0, -9.81]';  % Gravitational acceleration vector in inertial frame
    g_body = quatRotation(quatconj(q'), g_inertial);  % Rotate gravity vector to body frame
    Tgg = cross(R_cm, Ms * g_body);  % Calculate gravitational torque
end

function rotX = quatRotation(q, x)
    % Function: quatRotation
    % This function rotates a vector using a quaternion.
    %
    % Inputs:
    %   q - Quaternion representing the rotation
    %   x - 3D vector to be rotated
    %
    % Outputs:
    %   rotX - Rotated 3D vector

    qx = [0, x(1), x(2), x(3)];  % Convert vector to quaternion format
    q  = [q(1), q(2), q(3), q(4)];  % Ensure quaternion is in correct format
    qrotX = quatmultiply(quatmultiply(q, qx), quatconj(q));  % Apply quaternion rotation
    rotX = [qrotX(2); qrotX(3); qrotX(4)];  % Extract rotated vector from quaternion format
end
