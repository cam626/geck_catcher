classdef PlayerController
    properties
        gecko % the player object
        bugs % a bug object
        net
        worldSize = [1080 1080 1080]
        maxBugSpeed = 5;
    end
    methods
        % constructor
        function obj = PlayerController()
            obj.gecko = player();
            obj.bugs = (bug(obj.worldSize, obj.maxBugSpeed));
            obj.net = NetworkController("192.168.0.230");
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
            for bug = [1, length(obj.bugs)]
                obj.bugs(bug) = obj.bugs(bug).update();
            end
            
            obj = obj.updateAccel();
            obj = obj.updateVelocity();
            obj = obj.updatePosition();
        end
        
        % update the score
        function obj = updateScore(obj, collidedObject)
           obj.gecko.Score = obj.gecko.Score + collidedObject.PointValue; 
           obj.gecko.Size = obj.gecko.Size + collidedObject.SizeIncrease;
        end
        
        function obj = createRandomBug(obj)
            obj.bugs(end + 1) = bug(obj.worldSize, obj.maxBugSpeed);
        end
    end
end