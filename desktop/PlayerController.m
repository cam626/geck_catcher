classdef PlayerController
    properties
        gecko = player; % the player object
        buggo = SuperBug; %a bug object
    end
    methods
        function obj = updateAccel(obj)
            % Call cam's functions
            %A = newA();
            obj.gecko.A = [0.5,-1,1];
        end
        
        function obj = updateVelocity(obj)
            obj.gecko.V = obj.gecko.V + obj.gecko.A;
        end
        
        function obj = updatePosition(obj)
            obj.gecko.P = obj.gecko.V + obj.gecko.P;
        end
        
        function obj = updateValues(obj)
            obj = obj.updateAccel();
            obj = obj.updateVelocity();
            obj = obj.updatePosition();
        end
        
        function obj = UpdateScore(obj, collidedObject)
           obj.gecko.Score = obj.gecko.Score + collidedObject.PointValue; 
           obj.gecko.Size = obj.gecko.Size + collidedObject.SizeIncrease;
        end
    end
end