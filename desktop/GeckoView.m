classdef GeckoView
    properties
        world % vrworld scene tree
        gecko % player transform node
        % TODO add bug node fields
    end
    
    methods
        function obj = GeckoView()
            obj.world = vrworld('desktop/assets/base_world.x3d', 'new');
            open(obj.world);

            % Create/place gecko
            obj.gecko = vrimport(obj.world, "desktop/assets/gecko.STL");
            obj.gecko.scale = [0.07 0.07 0.07];
            obj.world.gecko_even_better_Material.diffuseColor = [0.2 1 0.4];
            obj.place_gecko([0 0 0], [0 0 -1]);
            
            view(obj.world);
        end
        
        function update(obj, controller)
            gecko_position = normalize_position(controller.getGecko().getPosition(), ...
                controller.getWorldSize());
            gecko_velocity = controller.getGecko().getVelocity();
            obj.place_gecko(gecko_position, gecko_velocity);
            
            % TODO implement bug updating/adding/removal
        end
        
        function place_gecko(obj, position, velocity)
            pos_offset = [-2.2 0 0.4]; % world-space offset for gecko model
            derived_pos = to_world_space(position) + pos_offset;
            % ignore Y position component
            obj.gecko.translation = [derived_pos(1) 0 derived_pos(3)];

            % set rotation (convert velocity to axis-angle rotation)
            direction = [velocity(1) 0 velocity(3)];
            axis = [0 1 0]; % use vertical axis
            angle = atan2(direction(3), direction(1));
            obj.gecko.rotation = [axis(1) axis(2) axis(3) angle];
        end
    end
end
        
% transforms position from (0,0,0)->(size,size,size) to (-1,-1,-1)->(1,1,1)
function pos = normalize_position(position, size)
    unit_pos = [position(1)/size(1) position(2)/size(2) position(3)/size(3)];
    pos = (unit_pos * 2) + [-1 -1 -1];
end

function pos = to_world_space(position)
    pos = position*12;
end
