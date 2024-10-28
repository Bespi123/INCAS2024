%%%ADCS module parameters
sat.J = [2.8E-3,3.4E-3,4.0E-3,-0.000559843,-1.68469e-05,-6.19637e-06];
sat.cg = rand(3,1)*1E-5;
sat.alpha = 4.01343e-14;
sat.miss = [0,0,-2.22547e-05]';
sat.m_sat = 1.317;


%%%Motor Parameters
%%Nominal motor values (estimated from real Data)
motor.kt = 0.000872234;  %kt 
motor.Jrw  = 2.55E-05;   %J
motor.b  = 1.00023E-05;  %B
motor.c = 0.000435786;   %kc
motor.L  = 0.000176564;  %H  
motor.R  = 1.23424;      %R    
motor.ke = 0.00966471;   %ke

%%Initial conditions
init.w_rw = 0;
init.current = 0; 

%%%Controller for estimation gains
esti.Gamma = [1,1,1];
esti.initial = [1,0,0,0,0,0,0];
esti.gamma = 1;

%%% Permanent excitation values
% esti.a  = 2;
%esti.nu = 2;
esti.a  = 0.5;
esti.nu = 0.5;

%%%Adaptive PID gains
adap.lambda = 5;
adap.n = 20;
adap.alpha = 3;
adap.beta = 5;
adap.epsilon = 0.001;

%%%Adaptive PID gains
adap.lambda =5;
adap.n = 1;
adap.alpha = 5;
adap.beta = 5;
adap.epsilon = 0.1;


%%%Initial Conditions
adap.kd_init = 0;
adap.ki_init = 0;
adap.kp_init = 0;
%adap.kd_init = 0;
%adap.ki_init = 0.0107348710799452;
%adap.kp_init = 0.0125748602658066;


% Parámetros iniciales del controlador adaptativo
Kp_init = 1;    % Ganancia proporcional inicial

% Parámetros de adaptación
gamma_p = 0.1;  % Tasa de adaptación para Kp
