classdef NetworkController
   properties
       address
   end
   
   methods
       function obj = NetworkController(addrStr)
           obj.address = addrStr;
       end
       
        function [vec] = getAcceleration(obj)
            uri = strcat('http://', obj.address, '/get?accX&accY&accZ');
            packet = webread(uri);

            accX = packet.buffer.accX.buffer;
            accY = packet.buffer.accY.buffer;
            accZ = packet.buffer.accZ.buffer;
            vec = [accX, accY, accZ];
        end
   end
   
end