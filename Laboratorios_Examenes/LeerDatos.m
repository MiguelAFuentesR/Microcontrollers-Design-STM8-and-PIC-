close all;
clear all;
clear device
device = serialport("COM9",9600)
grafica = animatedline('Color','r','LineWidth',3); 
while true 
Data = readline(device)
% ADC = split(Data,',')
% conversion = str2double(ADC)
% Transposicion = transpose(conversion)
% x = Transposicion(1,1)
% y = Transposicion(1,2)
% grid on;
% ylim([-100,1100])
% xlim([-100,1100])
% xlabel('ADC_X')
% ylabel('ADC_Y')
% title('Muestra en Tiempo Real Joystick');
% addpoints(grafica,y,x)
% drawnow
end

% Reiniciar Comunicacion : 
% clear device