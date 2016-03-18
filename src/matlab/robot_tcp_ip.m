function result = tcp_ip_with_robot(varargin)

if strcmp(varargin,'getTCPOBJ')
    disp('getTCPOBJ');
    result = getTCPOBJ;
end

% % %% TCP/IP CONNECTION SCRIPT
% % % Robot IP address and port
% % tcp_obj = tcpip('192.168.1.180',1234,'Timeout',10);
% % % Remember to set Terminator character for the 'tcp_obj' object. When we
% % % read 'carriage return' followed by 'linefeed', then we are at the end of the
% % % message
% % tcp_obj.Terminator = {'CR/LF' 'CR/LF'};
% % 
% % %%
% % % Open tcp/ip connection
% % fopen(tcp_obj);
% % 
% % %%
% % % Write message to robot when connecting e.g. for handshaking (optional)
% % fwrite(tcp_obj,'Hello sever')
% % 
% % %%
% % fwrite(tcp_obj,'10')
% % 
% % % Scan for response if necessary
% % fscanf(tcp_obj)
% % fscanf(tcp_obj)
% % %%
% % % Scan for response e.g. for handshaking (optional)
% % fscanf(tcp_obj);
% % 
% % %%
% % % Construct a message to send to the robot (tag, x, y, z, yaw, pitch, roll, approach, depart)
% % tag = 100;
% % x = 447.4962;
% % y = -34.11368;
% % z = 650.1371;
% % yaw = -21.4054;
% % pitch = 155.9617;
% % roll = 89.65516;
% % approach = 0;
% % depart = 0;
% % 
% % message = sprintf('%d,%d,%d,%d,%d,%d,%d,%d,%d',tag,x,y,z,yaw,pitch,roll,approach, depart);
% % 
% % % Send message to robot
% % fwrite(tcp_obj,message);
% % %%
% % 
% % % Scan for response if necessary
% % fscanf(tcp_obj);
% % 
% % % Close tcp/ip connection
% % fclose(tcp_obj);
end

%%
function tcpOBJ = getTCPOBJ()
tcpOBJ = tcpip('172.16.141.110',1234,'Timeout',10);
tcpOBJ.Terminator = {'CR/LF' 'CR/LF'};
end