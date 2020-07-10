classdef player
    % Player class
    % Initializing physics vectors to 0
    properties
        A = [0 0 0]; % Acceleration vector
        V = [0 0 0]; % Velocity Vector
        P = [0 0 0]; % Position Vector
        Sprite % sprite image data if we go that way
        Color % Gecko color if we use shapes
        Score = 0; % The player's current score
        Size = 1; % If we are growing like in the snake game
    end
    
    methods
        function pos = getPosition(obj)
            pos = obj.P;
        end
        
        function vel = getVelocity(obj)
            vel = obj.V;
        end
        
        function acc = getAcceleration(obj)
            acc = obj.A;
        end
    end
end

