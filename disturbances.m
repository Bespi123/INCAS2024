function Td_body = disturbances(entr)
    %%% Module quaternions
    q  = [entr(1),entr(2),entr(3),entr(4)]';
    %%% Angular rates in body frame
    w  = [entr(5),entr(6),entr(7)]';
    %%Gravity center offset
    cg = [entr(8),entr(9),entr(10)]';
    %%Air friction coef
    alpha = entr(11);
    %%Miscelaneous torques
    mis_inertial_Frame = [entr(12),entr(13),entr(14)]';
    m_sat = entr(15); 

    %%Get disturbances in body frame
    %get w in the inertial frame
    w_inertia = quatRotation(q,w);
    T_air_inertia = [0,0,alpha*w_inertia(3)]';
    T_air_body = quatRotation(quatconj(q'),T_air_inertia);
    
    
    T_gg_body  = T_disturbances(m_sat,cg,q);
    mis_body_Frame = quatRotation(quatconj(q'),mis_inertial_Frame);

    Td_body = T_gg_body-T_air_body+mis_body_Frame; 
end

function [ Tgg ] = T_disturbances(Ms,R_cm,q)
     g_inertial     = [0,0,-9.81]';
     g_body         = quatRotation(quatconj(q'),g_inertial);
     Tgg = cross(R_cm,Ms*g_body);
end

function rotX = quatRotation(q,x)
   qx = [0,    x(1), x(2), x(3)];
   q  = [q(1), q(2), q(3), q(4)];
   qrotX = quatmultiply(quatmultiply(q, qx), quatconj(q));
   rotX = [qrotX(2);qrotX(3);qrotX(4)];
end
