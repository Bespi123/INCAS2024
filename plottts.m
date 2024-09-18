simulationParameters   
%salidas=sim('simulationComplete.slx','SrcWorkspace','current');

%%
yout = salidas.get('yout');
t    = salidas.get('tout');

Td =yout{1}.Values;
J  =yout{2}.Values; 
J_e=yout{3}.Values;
u  =yout{4}.Values;
x  =yout{5}.Values;
xd =yout{6}.Values;
Wrwcom=yout{7}.Values;
Wrw=yout{8}.Values;
u_real = yout{9}.Values;
v1 = yout{10}.Values;
v2 = yout{11}.Values;
v3 = yout{12}.Values;
kp1 = yout{13}.Values;
kp2 = yout{14}.Values;
kp3 = yout{15}.Values;

%% Plot
figure()
s1 = subplot(6,1,1);
plot(t,J_e.Data(:,1),'r.'); grid on;
ylabel('J_{11} (Nm^2)'); title('Inertia estimation error');
s2 = subplot(6,1,2);
plot(t,J_e.Data(:,2),'r.');grid on;
ylabel('J_{22} (Nm^2)'); 
s3 = subplot(6,1,3);
plot(t,J_e.Data(:,3),'r.'); grid on;
ylabel('J_{33} (Nm^2)'); 
s4 = subplot(6,1,4);
plot(t,J_e.Data(:,4),'r.');grid on;
ylabel('J_{12} (Nm^2)'); 
s5 = subplot(6,1,5);
plot(t,J_e.Data(:,5),'r.');grid on;
ylabel('J_{13} (Nm^2)'); 
s6 = subplot(6,1,6);
plot(t,J_e.Data(:,6),'r.');grid on;
ylabel('J_{23} (Nm^2)'); 
xlabel('time(s)')

linkaxes([s1,s2,s3,s4,s5,s6],'x')

%%
figure()
s1 = subplot(3,1,1);
plot(t,kp1.Data,'r.'); grid on;
ylabel('K_p for RW 1'); title('Proportional gain for each reaction Wheel');
s2 = subplot(3,1,2);
plot(t,kp2.Data,'r.');grid on;
ylabel('K_p for RW 2')
s3 = subplot(3,1,3);
plot(t,kp3.Data,'r.'); grid on;
ylabel('K_p for RW 3'); xlabel('time(s)')

linkaxes([s1,s2,s3],'x')

figure()
s1 = subplot(3,1,1);
	h1 = plot(t,Wrw.Data(:,1)); hold on; grid on;
	h2 = plot(t,Wrwcom.Data(:,1),'--'); 
	ylabel('\omega_{rw_1}'); title('Reaction Wheels rates');
	legend([h1,h2],{'Angular rate','Command'})
s2 = subplot(3,1,2);
	h1 = plot(t,Wrw.Data(:,2)); hold on; grid on;
	h2 = plot(t,Wrwcom.Data(:,2),'--'); 
	ylabel('\omega_{rw_2}'); 
	legend([h1,h2],{'Angular rate','Command'})
s3 = subplot(3,1,3);
	h1 = plot(t,Wrw.Data(:,3)); hold on; grid on;
	h2 = plot(t,Wrwcom.Data(:,3),'--'); 
	ylabel('\omega_{rw_3}'); xlabel('time (s)');
	legend([h1,h2],{'Angular rate','Command'})


linkaxes([s1,s2,s3],'x')
%%
figure()
s1 = subplot(3,1,1);
	h1 = plot(t,u.Data(:,1)-u_real.Data(:,1)); grid on;
	ylabel('T_x error'); title('Torque errors');
s2 = subplot(3,1,2);
	h1 = plot(t,u.Data(:,2)-u_real.Data(:,2)); grid on;
	ylabel('T_y error'); 
s3 = subplot(3,1,3);
	h1 = plot(t,u.Data(:,3)-u_real.Data(:,3)); grid on;
	ylabel('T_z error'); xlabel('time(s)');

linkaxes([s1,s2,s3],'x')

%% FFT ANALISYS
[f0,P0,top_three_pks0, top_three_freq0, constant0, t_uniform0, x_uniform0] = fftAalisys(0,t,J_e.Data(:,1));
[f1,P1,top_three_pks1, top_three_freq1, constant1, t_uniform1, x_uniform1] = fftAalisys(0,t,J_e.Data(:,2));
[f2,P2,top_three_pks2, top_three_freq2, constant2, t_uniform2, x_uniform2] = fftAalisys(0,t,J_e.Data(:,3));
[f3,P3,top_three_pks3, top_three_freq3, constant3, t_uniform3, x_uniform3] = fftAalisys(0,t,J_e.Data(:,4));
[f4,P4,top_three_pks4, top_three_freq4, constant4, t_uniform4, x_uniform4] = fftAalisys(0,t,J_e.Data(:,5));
[f5,P5,top_three_pks5, top_three_freq5, constant5, t_uniform5, x_uniform5] = fftAalisys(0,t,J_e.Data(:,6));

%%
[f6,P6,top_three_pks6, top_three_freq6, constant6, t_uniform6, x_uniform6] = fftAalisys(0,t,Td.Data(:,1));
[f7,P7,top_three_pks7, top_three_freq7, constant7, t_uniform7, x_uniform7] = fftAalisys(0,t,Td.Data(:,2));
[f8,P8,top_three_pks8, top_three_freq8, constant8, t_uniform8, x_uniform8] = fftAalisys(0,t,Td.Data(:,3));

%%
figure()
subplot(1,2,1)
h0=plot(f0, P0,'-');hold on; grid on;
h1=plot(f1, P1,'-');
h2=plot(f2, P2,'-');
h3=plot(f3, P3,'-');
h4=plot(f4, P4,'-');
h5=plot(f5, P5,'-');
%plot(top_three_freq0, top_three_pks0, 'ro', 'MarkerSize', 10);  % Marcadores rojos en los picos
title('J Estimated'); xlim([0 0.4]);
%subtitle('J_{11} FFT')
legend([h0,h1,h2,h3,h4,h5],{'J_{11}','J_{22}','J_{33}','J_{12}','J_{13}','J_{23}'})
xlabel('Frequency (Hz)'); ylabel('Amplitude'); grid on;

subplot(1,2,2)
h7=plot(f6, P6,'-');hold on; grid on;
h8=plot(f7, P7,'-');
h9=plot(f8, P8,'-');
%plot(top_three_freq0, top_three_pks0, 'ro', 'MarkerSize', 10);  % Marcadores rojos en los picos
title('Disturbances'); xlim([0 0.4]);
%subtitle('J_{11} FFT')
legend([h7,h8,h8],{'Td_{x}','Td_{y}','Td_{z}'})
xlabel('Frequency (Hz)'); ylabel('Amplitude'); grid on;

%%
figure()
h0=plot(f0, P0,'-');hold on; grid on;
h1=plot(f1, P1,'-');
h2=plot(f2, P2,'-');
h3=plot(f3, P3,'-');
h4=plot(f4, P4,'-');
h5=plot(f5, P5,'-');

h3=plot(f6, P6,'-');
h4=plot(f7, P7,'-');
h5=plot(f8, P8,'-');

%%
% Display results for the first dataset
fprintf('Dataset 1:\n');
fprintf('Top 3 Peaks: %f, %f, %f\n', top_three_pks0(1), top_three_pks0(2), top_three_pks0(3));
fprintf('Top 3 Frequencies: %f, %f, %f\n', top_three_freq0(1), top_three_freq0(2), top_three_freq0(3));
fprintf('Constant: %f\n\n', constant0);

% Display results for the second dataset
fprintf('Dataset 2:\n');
fprintf('Top 3 Peaks: %f, %f, %f\n', top_three_pks1(1), top_three_pks1(2), top_three_pks1(3));
fprintf('Top 3 Frequencies: %f, %f, %f\n', top_three_freq1(1), top_three_freq1(2), top_three_freq1(3));
fprintf('Constant: %f\n\n', constant1);

% Display results for the third dataset
fprintf('Dataset 3:\n');
fprintf('Top 3 Peaks: %f, %f, %f\n', top_three_pks2(1), top_three_pks2(2), top_three_pks2(3));
fprintf('Top 3 Frequencies: %f, %f, %f\n', top_three_freq2(1), top_three_freq2(2), top_three_freq2(3));
fprintf('Constant: %f\n\n', constant2);

% Display results for the fourth dataset
fprintf('Dataset 4:\n');
fprintf('Top 3 Peaks: %f, %f, %f\n', top_three_pks3(1), top_three_pks3(2), top_three_pks3(3));
fprintf('Top 3 Frequencies: %f, %f, %f\n', top_three_freq3(1), top_three_freq3(2), top_three_freq3(3));
fprintf('Constant: %f\n\n', constant3);

% Display results for the fifth dataset
fprintf('Dataset 5:\n');
fprintf('Top 3 Peaks: %f, %f, %f\n', top_three_pks4(1), top_three_pks4(2), top_three_pks4(3));
fprintf('Top 3 Frequencies: %f, %f, %f\n', top_three_freq4(1), top_three_freq4(2), top_three_freq4(3));
fprintf('Constant: %f\n\n', constant4);

% Display results for the sixth dataset
fprintf('Dataset 6:\n');
fprintf('Top 3 Peaks: %f, %f, %f\n', top_three_pks5(1), top_three_pks5(2), top_three_pks5(3));
fprintf('Top 3 Frequencies: %f, %f, %f\n', top_three_freq5(1), top_three_freq5(2), top_three_freq5(3));
fprintf('Constant: %f\n\n', constant5);

% Display results for the seventh dataset
fprintf('Dataset 7:\n');
fprintf('Top 3 Peaks: %f, %f, %f\n', top_three_pks6(1), top_three_pks6(2), top_three_pks6(3));
fprintf('Top 3 Frequencies: %f, %f, %f\n', top_three_freq6(1), top_three_freq6(2), top_three_freq6(3));
fprintf('Constant: %f\n\n', constant6);

% Display results for the eighth dataset
fprintf('Dataset 8:\n');
fprintf('Top 3 Peaks: %f, %f, %f\n', top_three_pks7(1), top_three_pks7(2), top_three_pks7(3));
fprintf('Top 3 Frequencies: %f, %f, %f\n', top_three_freq7(1), top_three_freq7(2), top_three_freq7(3));
fprintf('Constant: %f\n\n', constant7);

% Display results for the ninth dataset
fprintf('Dataset 9:\n');
fprintf('Top 3 Peaks: %f, %f, %f\n', top_three_pks8(1), top_three_pks8(2), top_three_pks8(3));
fprintf('Top 3 Frequencies: %f, %f, %f\n', top_three_freq8(1), top_three_freq8(2), top_three_freq8(3));
fprintf('Constant: %f\n\n', constant8);

%%
[peak0,peak_freq0]=getpeaks(P0,f0);
[peak1,peak_freq1]=getpeaks(P1,f1);
[peak2,peak_freq2]=getpeaks(P2,f2);
[peak3,peak_freq3]=getpeaks(P3,f3);
[peak4,peak_freq4]=getpeaks(P4,f4);
[peak5,peak_freq5]=getpeaks(P5,f5);
[peak6,peak_freq6]=getpeaks(P6,f6);
[peak7,peak_freq7]=getpeaks(P7,f7);
[peak8,peak_freq8]=getpeaks(P8,f8);

%%
% Supongamos que ya tienes las siguientes variables:
% [peak0, peak_freq0], [peak1, peak_freq1], ..., [peak8, peak_freq8]

% Crea una figura
figure;

% Define los datos para el gráfico
peaks = {peak0, peak1, peak2, peak3, peak4, peak5, peak6, peak7, peak8};
frequencies = {peak_freq0, peak_freq1, peak_freq2, peak_freq3, peak_freq4, peak_freq5, peak_freq6, peak_freq7, peak_freq8};

% Color y estilo para cada conjunto de datos
colors = lines(numel(peaks));
styles = {'-', '--', '-.', ':'}; % Diferentes estilos de línea
markers = {'o', 's', '^', 'd', 'p', 'h', 'x', '+', '*'}; % Diferentes marcadores

% Gráfico de todos los picos y frecuencias
hold on; % Mantiene el gráfico actual para añadir más datos
for i = 1:numel(peaks)
    if i > numel(peaks) - 3 % Los últimos tres conjuntos de datos
        style = styles{mod(i-1, numel(styles)) + 1}; % Ciclado de estilos
        marker = markers{mod(i-1, numel(markers)) + 1}; % Ciclado de marcadores
        color = colors(i, :); % Color específico para cada conjunto
        w=50;
        % Combina estilo y marcador
        plot_style = [style, marker];
    else
        style = '-'; % Estilo de línea sólida para otros conjuntos de datos
        marker = 'o'; % Marcador estándar
        color = colors(i, :); % Color específico para cada conjunto
        plot_style = [style, marker];
        w=3;
    end
    stem(frequencies{i}, peaks{i}, plot_style, 'MarkerSize', w,'Color', color, 'DisplayName', sprintf('Dataset %d', i));
end
hold off;

% Ajusta el rango del eje x
xlim([0 0.4]);

% Añadir etiquetas y título
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
title('Picos en el Espectro FFT para Diferentes Conjuntos de Datos');
legend('show'); % Muestra la leyenda con los nombres de los conjuntos de datos
grid on;



function [f, P1, top_three_pks, top_three_freq, constant, t_uniform, x_uniform] = fftAalisys(t_start,tout,normTtorque)
    % Interpolación para tener un muestreo uniforme
    t_start_seconds = find(abs(t_start -(tout/3600)) < 1e-4);
    temp = diff(tout(t_start_seconds(end):end));
    t_sample = min(temp(1:end-1));
    t_uniform = tout(t_start_seconds(end)):t_sample:tout(end);  % Definir un vector de tiempo uniforme
    
    x_uniform = interp1(tout(t_start_seconds(end):end), normTtorque(t_start_seconds(end):end), t_uniform, 'spline');  % Interpolación
     
    % Calcular la FFT de la señal uniforme
    Fs = 1 / (t_uniform(2) - t_uniform(1));  % Frecuencia de muestreo
    L = length(x_uniform);  % Longitud de la señal
    Y = fft(x_uniform);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
     
    % Encontrar los picos
    [pks, locs] = findpeaks(P1);
    % Ordenar los picos en orden descendente por valor
    [sorted_pks, sorted_idx] = sort(pks, 'descend');
    % Seleccionar los tres valores más altos
    top_three_pks = sorted_pks(1:3);
    top_three_locs = locs(sorted_idx(1:3));
    top_three_freq = f(top_three_locs);
    
    %Add constant component
    constant = P1(1);
   
end

function [peaks,peak_freqs] = getpeaks(P1,f)
% Encuentra los picos
    [peaks, locs] = findpeaks(P1); % Ajusta según necesidad

    % Obtén las frecuencias correspondientes a todos los picos encontrados
    peak_freqs = f(locs);
end