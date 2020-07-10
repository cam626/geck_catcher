classdef PlayerController
    properties
        gecko = player; % the player object
        buggo = xBug; % a bug object
        buggo2 = bug; % a second bug
    end
    methods
        % updates the accelerations
        function obj = updateAccel(obj)
            % Call cam's functions
            % A = newA();
            obj.gecko.A = [0.5,-1,1];
        end
        
        % updates the velocity
        function obj = updateVelocity(obj)
            obj.gecko.V = obj.gecko.V + obj.gecko.A;
        end
        
        % update position
        function obj = updatePosition(obj)
            obj.gecko.P = obj.gecko.V + obj.gecko.P;
        end
        
        % update the physics of the gecko
        function obj = updateValues(obj)
            obj = obj.updateAccel();
            obj = obj.updateVelocity();
            obj = obj.updatePosition();
        end
        
        % update the score
        function obj = updateScore(obj, collidedObject)
           obj.gecko.Score = obj.gecko.Score + collidedObject.PointValue; 
           obj.gecko.Size = obj.gecko.Size + collidedObject.SizeIncrease;
        end
    end
end