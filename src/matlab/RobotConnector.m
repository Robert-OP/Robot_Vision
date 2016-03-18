%% HOWTO
% myConnector = RobotConnector('192.168.1.180',1234)
% 
% myConnector = 
% 
%   RobotConnector with properties:
% 
%     tcpipSocket: [1x1 tcpip]
%     hostAddress: '192.168.1.180'
%        hostPort: 1234
%           debug: 0
% 
% myConnector.delete
% myConnector = RobotConnector('192.168.1.180',1234)
% 
% myConnector = 
% 
%   RobotConnector with properties:
% 
%     tcpipSocket: [1x1 tcpip]
%     hostAddress: '192.168.1.180'
%        hostPort: 1234
%           debug: 0
% 
% 
% myConnector.openGrapper
% myConnector.closeGrapper
%% classdef
classdef RobotConnector
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        tcpipSocket;
        hostAddress = '172.16.141.110';
%         hostAddress = '129.233.11.40';
%         hostPort = 59002;
        hostPort = 1234;
        debug = false;
    end
    
    methods
        % Constructor
        function obj = RobotConnector(hostAddress_,hostPort_)
            % See if connector is started with an argument
            if nargin > 0
                obj.hostAddress = hostAddress_;
                obj.hostPort = hostPort_;
            end
            
            % Connect to the server
            obj.tcpipSocket = tcpip(obj.hostAddress,obj.hostPort);
            
            try
                fopen(obj.tcpipSocket);
            catch err
               disp(['COULD NOT CONNECT TO SERVER: ' err.message]);
               %rethrow(err);
            end          
        end
        
        % Destructor
        function delete(obj)
            fclose(obj.tcpipSocket);
            delete(obj.tcpipSocket);
        end
        
        %******** Move functions
        % Move Joint 
        function moveJoint(obj,varargin) % moveJoint(x,y,z,w,p,r,speed) or moveJoint(A,speed) where A = [ x y z w p r ];
    
            if nargin == 3
                A = varargin{1};
                if (length(A) == 6 )
                    x = A(1); y = A(2); z = A(3); w = A(4); p = A(5); r = A(6);
                else
                    disp(['Position matrix has the wrong dimension, expected 6, but got: ' num2str(length(A))]);
                    return;
                end
                speed=varargin{2};
            elseif nargin == 8
               x  = varargin{1}; y = varargin{2}; z = varargin{3}; w = varargin{4}; p = varargin{5}; r = varargin{6}; 
               speed = varargin{7};
            else
                disp(['Incorrect number of argumets, expected 2 or 7, but found: ' num2str(nargin) ]);
                return;
            end
            
            str = [ 'MOVEJ;[' num2str(x) ',' num2str(y) ',' num2str(z) ',' num2str(w) ',' num2str(p) ',' num2str(r) ',' num2str(speed) '];' 10 ];
            robotSend(obj,str);
            robotWait(obj,['MOVEJ;started;' 10]); % Wait for commands
            robotWait(obj,['MOVEJ;ended;' 10]);
        end
        
        % Move Linear 
        function moveLinear(obj,varargin) % moveLinear(x,y,z,w,p,r,speed) or moveLinear(A,speed) where A = [ x y z w p r ];
    
            if nargin == 3
                A = varargin{1};
                if (length(A) == 6 )
                    x = A(1); y = A(2); z = A(3); w = A(4); p = A(5); r = A(6);
                else
                    disp(['Position matrix has the wrong dimension, expected 6, but got: ' num2str(length(A))]);
                    return;
                end
                speed=varargin{2};
            elseif nargin == 8
               x  = varargin{1}; y = varargin{2}; z = varargin{3}; w = varargin{4}; p = varargin{5}; r = varargin{6}; 
               speed = varargin{7};
            else
                disp(['Incorrect number of argumets, expected 2 or 7, but found: ' num2str(nargin) ]);
                return;
            end
            
            str = [ 'MOVEL;[' num2str(x) ',' num2str(y) ',' num2str(z) ',' num2str(w) ',' num2str(p) ',' num2str(r) ',' num2str(speed) '];' 10 ];
            robotSend(obj,str);
            robotWait(obj,['MOVEL;started;' 10]); % Wait for commands
            robotWait(obj,['MOVEL;ended;' 10]);
        end

               
        % Move Relative Joint
        function moveRelativeJoint(obj,varargin) % moveRelativeJoint(x,y,z,w,p,r,speed) or moveRelativeJoint(A,speed) where A = [ x y z w p r ];
    
            if nargin == 3
                A = varargin{1};
                if (length(A) == 6 )
                    x = A(1); y = A(2); z = A(3); w = A(4); p = A(5); r = A(6);
                else
                    disp(['Position matrix has the wrong dimension, expected 6, but got: ' num2str(length(A))]);
                    return;
                end
                speed=varargin{2};
            elseif nargin == 8
               x  = varargin{1}; y = varargin{2}; z = varargin{3}; w = varargin{4}; p = varargin{5}; r = varargin{6}; 
               speed = varargin{7};
            else
                disp(['Incorrect number of argumets, expected 2 or 7, but found: ' num2str(nargin) ]);
                return;
            end
            
            str = [ 'MOVEJR;[' num2str(x) ',' num2str(y) ',' num2str(z) ',' num2str(w) ',' num2str(p) ',' num2str(r) ',' num2str(speed) '];' 10 ];
            robotSend(obj,str);
            robotWait(obj,['MOVEJR;started;' 10]); % Wait for commands
            robotWait(obj,['MOVEJR;ended;' 10]);
        end
        
        % Move Relative Linear
        function moveRelativeLinear(obj,varargin) % moveRelaviteLinear(x,y,z,w,p,r,speed) or moveRelativeLinear(A,speed) where A = [ x y z w p r ];
    
            if nargin == 3
                A = varargin{1};
                if (length(A) == 6 )
                    x = A(1); y = A(2); z = A(3); w = A(4); p = A(5); r = A(6);
                else
                    disp(['Position matrix has the wrong dimension, expected 6, but got: ' num2str(length(A))]);
                    return;
                end
                speed=varargin{2};
            elseif nargin == 8
               x  = varargin{1}; y = varargin{2}; z = varargin{3}; w = varargin{4}; p = varargin{5}; r = varargin{6};
               speed = varargin{7};
            else
                disp(['Incorrect number of argumets, expected 2 or 7, but found: ' num2str(nargin) ]);
                return;
            end
            
            str = [ 'MOVELR;[' num2str(x) ',' num2str(y) ',' num2str(z) ',' num2str(w) ',' num2str(p) ',' num2str(r) ',' num2str(speed) '];' 10 ];
            disp(str);
            
            robotSend(obj,str);
            robotWait(obj,['MOVELR;started;' 10]); % Wait for commands
            robotWait(obj,['MOVELR;ended;' 10]);
        end
        
        % Open and close grabber
        function openGrapper(obj)
            str = [ 'GRABOFF;' 10 ];
            robotSend(obj,str);
            %robotWait(obj,['GRABON;started;' 10]); % Wait for commands
            %robotWait(obj,['GRABON;ended;' 10]);
        end
        
        function closeGrapper(obj)
            % str = [ 'MOVEL;[-3 12 -41 9 -36 0 20];'];
            str = [ 'GRABON;' 10 ];
            robotSend(obj,str);
            %robotWait(obj,['GRABOFF;started;' 10]); % Wait for commands
            %robotWait(obj,['GRABOFF;ended;' 10]);
        end
        
        %******** Get position function
        function A = getPosition(obj) % Retuenvalue  A = [x y z w p r]
            str = [ 'GETPOS;' 10 ];
            robotSend(obj,str);
            
            % Wait for the data to arraive and extract the returned position
            while (obj.tcpipSocket.BytesAvailable == 0)
            end
                
            % Read all the data available
            data = fread(obj.tcpipSocket,obj.tcpipSocket.BytesAvailable);
            data = char(data');
            
            if obj.debug == true
                disp(['Data Received: ' data ]);
            end
            
            
            % Get csv data inside inside square paranthesis
            data = regexpi(data,'[[]]','split');
            data = data{2};

            % Extract the values from the csv data
            vals = regexpi(data,' ','split');
            
            mask = zeros(length(vals),1);
            for i = 1:length(mask)
                if length(vals{i}) > 0
                    mask(i) = 1;
                end
            end
            mask = boolean(mask);
            
            vals = vals(mask);
            
            % Test if the correct number of cells has been received
            if ( length(vals) ~= 6 )
                disp(['Too few values in string, expected 6, but got: ' num2str(length(vals)) ]); 
                return;
            end

            % Form the resulting matrix
            A = [str2num(vals{1}) str2num(vals{2}) str2num(vals{3}) str2num(vals{4}) str2num(vals{5}) str2num(vals{6})];

        end
        
    end
    
end
    
function robotSend(obj,str)

    % Clear the incoming buffer
    robotClearBuf(obj);
    
    
    if obj.debug == true
        disp(['Data sent:     ' str(1:end-1)]);
    end
    
    fwrite(obj.tcpipSocket,str)
end

function robotWait(obj,str)
    % Wait for data to be ready
    while (obj.tcpipSocket.BytesAvailable == 0)
        
    end
    
    % Read all the data available
    data = fread(obj.tcpipSocket,obj.tcpipSocket.BytesAvailable);
    data = char(data');
    
    if obj.debug == true
        disp(['Data Received: ' data ]);
    end
    
    if strcmp(data,str) == 0
       disp(['DATA NOT AS EXPECTED! received: ' data]); 
    end 
    
end

function robotClearBuf(obj)
    
    if obj.tcpipSocket.BytesAvailable > 0
        % Read all the data available
        data = fread(obj.tcpipSocket,obj.tcpipSocket.BytesAvailable);
        data = char(data');

        if obj.debug == true
            disp(['Data Received (clear buf): ' data ]);
        end
    end
end
