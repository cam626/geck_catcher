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
        Size % If we are growing like in the snake game
    end
end

