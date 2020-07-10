classdef PlayerController
    properties
        gecko % the player object
        bugs % a bug object
        net % network operations
        worldSize = [1080 1080 1080]
        maxBugSpeed = 50;
        score = 0;
    end
    
    methods
        % constructor
        function obj = PlayerController()
            obj.gecko = player();
            obj.bugs = (bug(obj.worldSize, obj.maxBugSpeed));
            obj.net = NetworkController("192.168.1.241:8080");
        end
        
        % updates the accelerations
        function obj = updateAccel(obj)
            obj.gecko.A = obj.net.getAcceleration();
        end
        
        % updates the velocity
        function obj = updateVelocity(obj, dt)
            obj.gecko.V = obj.gecko.V + obj.gecko.A * dt;
        end
        
        % update position
        function obj = updatePosition(obj, dt)
            if obj.gecko.P(1) + obj.gecko.V(1) > obj.worldSize(1)
                obj.gecko.P(1) = obj.worldSize(1);
                obj.gecko.V(1) = 0;
            end
            
            if obj.gecko.P(1) + obj.gecko.V(1) < 0
                obj.gecko.P(1) = 0;
                obj.gecko.V(1) = 0;
            end
            
            if obj.gecko.P(2) + obj.gecko.V(2) > obj.worldSize(2)
                obj.gecko.P(2) = obj.worldSize(2);
                obj.gecko.V(2) = 0;
            end
            
            if obj.gecko.P(2) + obj.gecko.V(2) < 0
                obj.gecko.P(2) = 0;
                obj.gecko.V(2) = 0;
            end
            
            if obj.gecko.P(3) + obj.gecko.V(3) > obj.worldSize(3)
                obj.gecko.P(3) = obj.worldSize(3);
                obj.gecko.V(3) = 0;
            end
            
            if obj.gecko.P(3) + obj.gecko.V(3) < 0
                obj.gecko.P(3) = 0;
                obj.gecko.V(3) = 0;
            end
            
            obj.gecko.P = obj.gecko.P + obj.gecko.V * dt;
        end
        
        % update the physics of the gecko
        function obj = updateValues(obj, dt)
            for bug = [1, length(obj.bugs)]
                obj.bugs(bug) = obj.bugs(bug).update(dt);
            end
            
            obj = obj.updateAccel();
            obj = obj.updateVelocity(dt);
            obj = obj.updatePosition(dt);
            
            obj = obj.bugCollisions();
            
            if 500*rand(1) <= 1
                obj.createRandomBug();
            end
        end
        
        function obj = createRandomBug(obj)
            obj.bugs(end + 1) = bug(obj.worldSize, obj.maxBugSpeed);
        end
        
        function obj = bugCollisions(obj)
            for bug = length(obj.bugs):-1:1
                if obj.checkCollision(obj.gecko, obj.bugs(bug))
                    obj.bugs(bug) = [];
                    obj.score = obj.score + 1;
                end
            end
        end
        
        function collided = checkCollision(obj, player, bug)
            pos = player.getPosition();
            player_x = pos(1);
            player_y = pos(2);
            
            bug_pos = bug.getPosition();
            bug_x = bug_pos(1);
            bug_y = bug_pos(2);
            
            if player_x < bug_x + bug.getSize() && ...
                    player_x + player.getSize() > bug_x && ...
                    player_y < bug_y + bug.getSize() && ...
                    player_y + player.getSize() > bug_y
                collided = true;
            else
                collided = false;
            end
        end
    end
end