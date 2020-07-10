world = vrworld('desktop/assets/base_world.x3d', 'new');
open(world);
main(world);
view(world);

function main(world)
    % Attach reference to the camera
    H.camera = vrnode(world, 'BaseCamera');

    % Create/place gecko
    H.gecko = vrimport(world, "desktop/assets/gecko.STL");
    H.gecko.scale = [0.07 0.07 0.07];
    world.gecko_even_better_Material.diffuseColor = [0.2 1 0.4];
    place_gecko([1 0 1], [1 0 1]);

    function place_gecko(position, velocity)
        % set position
        pos_offset = [-2.2 0 0.4];
        pos_mult = 12;
        % ignore Y position component
        derived_pos = [position(1)*pos_mult 0 position(3)*pos_mult] + pos_offset;
        H.gecko.translation = derived_pos;

        % set rotation (convert velocity to axis-angle rotation)
        direction = [velocity(1) 0 velocity(3)];
        axis = [0 1 0]; % use vertical axis
        angle = atan2(direction(3), direction(1));
        H.gecko.rotation = [axis(1) axis(2) axis(3) angle];
    end
end
