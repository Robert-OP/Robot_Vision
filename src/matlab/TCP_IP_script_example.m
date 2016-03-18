 %% Robot to base
% TCP/IP CONNECTION SCRIPT
tcp_obj = tcpip('172.16.141.110',1234,'Timeout',10);
tcp_obj.Terminator = {'CR' 'LF'};
fopen(tcp_obj);
fwrite(tcp_obj,'Hello sever');
fscanf(tcp_obj);
 
% MOVE TO REFERENCE POINT AND OPEN GRIPPER
 message0_ref = sprintf('%d, %d ,%d, %d, %d, %d, %d, %d, %d', 100, 341.994, -292.605, 494.925, 134.713, 179.782, 0, 0, 0);
 fwrite(tcp_obj,message0_ref);
 fscanf(tcp_obj);
 
% OPEN GRIPPER
 message_ref = sprintf('%d, %d ,%d, %d, %d, %d, %d, %d, %d', 301, 341.994, -292.605, 494.925, 134.713, 179.782, 0, 0, 0);
 fwrite(tcp_obj,message_ref);
 fscanf(tcp_obj); 
 
% Close tcp/ip connection
 fclose(tcp_obj);