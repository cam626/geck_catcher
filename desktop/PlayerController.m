classdef PlayerController
    properties
        gecko % the player object
        bugs % a bug object
        net
    end
    methods
        % constructor
        function obj = PlayerController()
            obj.gecko = player;
            obj.bugs = [];
            obj.net = NetworkController("123");
        end
        
        % updates the accelerations
        function obj = updateAccel(obj)
            obj.gecko.A = obj.net.getAcceleration();
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