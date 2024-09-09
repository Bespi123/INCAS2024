function [x_dot] = cubeSatEquationState(entr)
%LS2125204: Brayan Espinoza
% Inputs
%   Td: Disturbances
%   U: Input torque  
%   I: Rigid body inertia torque
%   q: Attitude Quaternion
%   w: CubeSat Angular rates[wx,wy,wz]
%   x: [q;w]

Td = [entr(1),entr(2),entr(3)]';
I =  [entr(4),entr(7),entr(8);
      entr(7),entr(5),entr(9);
      entr(8),entr(9),entr(6)];
U = [entr(10),entr(11),entr(12)]';
%x = [entr(13),entr(14),entr(15),entr(16),entr(17),entr(18),entr(19)]';
q = [entr(13),entr(14),entr(15),entr(16)]';
w = [entr(17),entr(18),entr(19)]';
%Read inputs
%q=x(1:4);
%w=x(5:7);

%Kinematics and Dynamic Equations
%Book: Fundamentals of Spacecraft Attitude Determination and Control
%Author: F. Landis Markley & John L. Crassidis
%Quaternions Kinematics..EcuaciÃ³n (2.88)
Xi=[-q(2),-q(3),-q(4);
     q(1),-q(4),q(3);
     q(4),q(1),-q(2);
    -q(3),q(2),q(1)]; 
q_dot=1/2*Xi*w;                        %Kynematics Equation(3.21)
w_dot=I\(Td+U-cross(w,I*w));      %Dynamics EquatiÃ³n (3.147)

%x_dot Vector
x_dot=[q_dot;w_dot];
end