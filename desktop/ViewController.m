classdef ViewController
    properties
        world % vrworld scene tree
        gecko % player transform node
        bug_nodes % associative array of 3d pos => bug scene nodes
    end
    
    methods
        function obj = ViewController()
            obj.world = vrworld('desktop/assets/base_world.x3d', 'new');
            open(obj.world);

            % Create/place gecko
            obj.gecko = vrimport(obj.world, "desktop/assets/gecko.STL");
            obj.gecko.scale = [0.07 0.07 0.07];
            obj.world.gecko_even_better_Material.diffuseColor = [0.2 1 0.4];
            % TODO: this needs an inner transform to correct its position
            % to center it in world space
            % http://edutechwiki.unige.ch/en/X3D_grouping_and_transforms
            obj.place_gecko([0 0 0], [0 0 -1]);
            
            % Initialize bugs map
            obj.bug_nodes = containers.Map;
            
            view(obj.world);
        end
        
        function update(obj, controller)
            gecko_position = normalize_position(controller.gecko.getPosition(), ...
                controller.worldSize);
            gecko_velocity = controller.gecko.getVelocity();
            obj.place_gecko(gecko_position, gecko_velocity);
            
            % I'm not super sure if any of this works since I've never used
            % maps/lists/arrays/sets in matlab before
            new_list = controller.bugs;
            to_add = {};
            all_positions = {};
            for i = 1 : length(new_list)
                new_bug = new_list(i);
                position = new_bug.getPosition();
                all_positions{length(all_positions)+1} = make_key(position);
                if ~isKey(obj.bug_nodes, make_key(new_bug.getPosition()))
                    to_add{length(to_add)+1} = new_bug;
                end
            end
            
            for i = 1 : length(to_add)
                obj.add_bug(to_add{i}, controller.worldSize);
            end
            
            % TODO how does matlab work?
            a = cell2mat(obj.bug_nodes.keys());
            to_remove = setdiff(cell2mat(obj.bug_nodes.keys()), cell2mat(all_positions));
            for i = 1 : length(to_remove)
               obj.remove_bug(to_remove(i));
            end
        end
        
        function remove_bug(obj, oldpos_key)
           node = obj.bug_nodes(oldpos_key);
           remove(obj.bug_nodes, oldpos_key);
           delete(node);
        end
        
        function add_bug(obj, bug, size)
           bug_node = vrimport(obj.world, "desktop/assets/bug.STL");
           % TODO is this the correct scale
           position = normalize_position(bug.getPosition(), size);
           bug_node.translation = to_world_space(position);
           % TODO rotate/scale/transform correctly to normalize
           % (might need inner transform)
           bug_node.scale = [0.02 0.02 0.02];
           obj.bug_nodes(make_key(bug.getPosition())) = bug_node;
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

function key = make_key(vec)
    key = strcat("key__", num2str(vec(1)), "&&", num2str(vec(2)), "##", num2str(vec(3)));
end

function pos = to_world_space(position)
    pos = position*12;
end