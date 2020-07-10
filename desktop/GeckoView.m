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
    place_gecko([0 0 0], [0 0 1]);

    %% Create Dialog
    % The dialog is used to interactively change field values of the VRML node
    % referred to by the VRNODE object just created.

    figh = dialog('Position',[358 402 530 107], 'Name', 'Simulink 3D Animation Example', ...
                  'WindowStyle', 'normal', ...
                  'CloseRequestFcn', @on_close);

    %% Create Rotation Control

    uicontrol('Parent',figh, 'Position',[84 68 80 14], 'HorizontalAlignment','left', ...
              'String','X1', 'Style','text');
    H.x = uicontrol('Parent',figh, 'Style','slider', 'Position',[164 65 352 20], ...
                           'Min', -1, 'Max', 1);
                       
    uicontrol('Parent',figh, 'Position',[84 68 80 14], 'HorizontalAlignment','left', ...
              'String','X1', 'Style','text');
    H.x = uicontrol('Parent',figh, 'Style','slider', 'Position',[164 65 352 20], ...
                           'Min', -1, 'Max', 1);
                       
    addlistener(H.translation, 'Value', 'PostSet', @translation_changed);

    %% Create Rotation Control

    H.rotation = uicontrol('Parent',figh, 'Style','slider', ...
                       'Position',[164 4 352 20], 'Value', 1);

    uicontrol('Parent',figh, 'Position',[84 7 80 14], 'String','Zoom', ...
              'Style','text', 'HorizontalAlignment','left');
    addlistener(H.zoom, 'Value', 'PostSet', @zoom_changed);

      
    function translation_changed(~, ~)
        current_translation = get(H.translation, 'Value');
        cur_x = get(H.xaxis, 'Value');
        cur_y = get(H.yaxis, 'Value');
        cur_z = get(H.zaxis, 'Value');
        if (cur_x || cur_y || cur_z)
            set_gecko_transform([cur_x*current_translation 0 cur_z*current_translation], [0 0]);
        end
    end
      
    function zoom_changed(~, ~)
        H.camera.fieldOfView = 0.25 + 0.55 * (1-get(H.zoom,'Value'));
    end
      
    function on_close(~, ~)
        close(world);
        try
            delete(world);
        catch
            % No-op
        end
        closereq;
    end
    
    function set_gecko_translation(translate)
        H.gecko.rotation = rotation;
    end
    
    function set_gecko_transform(translate, rotation)
        H.gecko.scale = [0.07 0.07 0.07];
        H.gecko.rotation = rotation;
        set_gecko_translation(translate);
    end

    function place_gecko(position, velocity)
        base_translation_offset = [-2 0 -2];
        base_translation_multiplier = 14;
        H.gecko.translation = [ ...
            translate(1)*base_translation_multiplier ...
            0 ...
            translate(3)]*base_translation_multiplier ...
            + base_translation_offset;
       H.gecko
    end
end
