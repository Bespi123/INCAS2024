% Constantes del motor sin escobillas
motor.kt = 0.000872234;   % Constante de torque (kt)
motor.Jrw = 2.55E-05;     % Inercia del rotor (J)
motor.b = 1.00023E-05;    % Coeficiente de fricción viscosa (B)
motor.c = 0.000435786;    % Fricción de Coulomb (kc)
motor.L = 0.000176564;    % Inductancia del circuito (L)
motor.R = 1.23424;        % Resistencia eléctrica (R)
motor.ke = 0.00966471;    % Constante de contra-electromotriz (ke)

% Parámetros iniciales del controlador adaptativo
Kp_init = 1;    % Ganancia proporcional inicial

% Parámetros de adaptación
gamma_p = 0.1;  % Tasa de adaptación para Kp

% Simulación de tiempo
T_sim = 100;      % Tiempo de simulación total en segundos
dt = 0.0001;      % Paso de tiempo
t = 0:dt:T_sim;  % Vector de tiempo

% Variables de estado iniciales
w = 0;     % Velocidad angular inicial
i = 0;     % Corriente inicial
u = 0;     % Voltaje inicial

% Referencia deseada de velocidad angular
w_ref = 200;  % Objetivo de velocidad angular (rad/s)

% Inicialización de variables para almacenar resultados
w_history = zeros(size(t));  % Historial de velocidad angular
i_history = zeros(size(t));  % Historial de corriente
u_history = zeros(size(t));  % Historial de voltaje aplicado
Kp_history = zeros(size(t)); % Historial de Kp

% Inicialización de los parámetros del controlador adaptativo
Kp = Kp_init;  % Ganancia proporcional inicial
error_prev = 0;  % Error anterior

% Simulación del controlador adaptativo
for k = 1:length(t)
    % Calcular el error
    error = w_ref - w;  % Error de seguimiento
    
    % Controlador proporcional adaptativo
    u_pid = Kp * error;
    
    % Ley de adaptación de los parámetros basados en Lyapunov
    Kp = Kp + gamma_p * abs(error) * dt;  % Adaptar Kp en función del error
    
    % Restringir la salida del voltaje a los límites del sistema
    u = max(min(u_pid, 24), -24);  % Limitar el voltaje entre -24 y 24 V
    
    % Modelo del motor sin escobillas
    entr = [w; i; u; motor.kt; motor.Jrw; motor.b; motor.c; motor.L; motor.R; motor.ke];
    dx = BrushelessModel_simu(entr);
    
    % Actualizar las variables de estado
    w = w + dx(1) * dt;  % Actualizar velocidad angular
    i = i + dx(2) * dt;  % Actualizar corriente
    
    % Almacenar los valores actuales
    w_history(k) = w;
    i_history(k) = i;
    u_history(k) = u;
    Kp_history(k) = Kp;
    
    % Actualizar el error previo
    error_prev = error;
end

% Gráficas de los resultados
figure;
subplot(4,1,1);
plot(t, w_history);
xlabel('Tiempo (s)');
ylabel('Velocidad angular (rad/s)');
title('Respuesta de la velocidad angular con control adaptativo');
grid on;

subplot(4,1,2);
plot(t, i_history);
xlabel('Tiempo (s)');
ylabel('Corriente (A)');
title('Corriente en el motor');
grid on;

subplot(4,1,3);
plot(t, u_history);
xlabel('Tiempo (s)');
ylabel('Voltaje (V)');
title('Voltaje aplicado por el controlador adaptativo');
grid on;

subplot(4,1,4);
plot(t, Kp_history);
xlabel('Tiempo (s)');
ylabel('Kp');
title('Evolución de Kp (Ganancia Proporcional)');
grid on;

