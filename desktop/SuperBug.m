classdef SuperBug
    % bug super class
    properties (Access = private)
        Sprite % if we use sprites
        Color % if we use colors/shapes
        PointValue % how many points the item is worth
        SizeIncrease % how many units the gecko grows if we do that
    end
end