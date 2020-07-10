classdef SuperBug
    % bug super class
    properties (Access = private)
        Sprite % if we use sprites
        Color % if we use colors/shapes
        PointValue % how many points the item is worth
        SizeIncrease % how many units the gecko grows if we do that
        P
        V
        A
        worldWidth
        worldHeight
        worldDepth
    end
    
    methods
        function obj = SuperBug(worldSize, maxSpeed)
            obj.worldWidth = worldSize(1);
            obj.worldHeight = worldSize(2);
            obj.worldDepth = worldSize(3);
            
            obj.P = [obj.worldWidth*rand(1), obj.worldHeight*rand(1), obj.worldDepth*rand(1)];
            obj.V = -1 * maxSpeed / 2 + maxSpeed*rand(1, 3);
        end
        
        function obj = update(obj)
            if obj.P(1) + obj.V(1) > obj.worldWidth
                obj.P(1) = obj.worldWidth;
                obj.V(1) = obj.V(1) * -1;
            end
            
            if obj.P(1) + obj.V(1) < 0
                obj.P(1) = 0;
                obj.V(1) = obj.V(1) * -1;
            end
            
            if obj.P(2) + obj.V(2) > obj.worldHeight
                obj.P(2) = obj.worldHeight;
                obj.V(2) = obj.V(2) * -1;
            end
            
            if obj.P(2) + obj.V(2) < 0
                obj.P(2) = 0;
                obj.V(2) = obj.V(2) * -1;
            end
            
            if obj.P(3) + obj.V(3) > obj.worldDepth
                obj.P(3) = obj.worldDepth;
                obj.V(3) = obj.V(3) * -1;
            end
            
            if obj.P(3) + obj.V(3) < 0
                obj.P(3) = 0;
                obj.V(3) = obj.V(3) * -1;
            end
            
            obj.P = obj.P + obj.V;
        end
        
        function pos = getPosition(obj)
            pos = obj.P;
        end
    end
end