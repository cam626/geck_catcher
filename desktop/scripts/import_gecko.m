% Import an STL mesh, returning a PATCH-compatible face-vertex structure
fv = stlread('desktop/assets/gecko.stl');

% Render
% The model is rendered with a PATCH graphics object. We also add some dynamic
% lighting, and adjust the material properties to change the specular
% highlighting.

test = patch(fv, 'FaceColor', [0.1 0.5 1.0], ...
         'EdgeColor', 'none', ...
         'FaceLighting', 'gouraud', ...
         'AmbientStrength', 0.15);
     
% Have to make the patch a lower resolution smaller to run with less lag
reducepatch(test, 0.15)

% Add a camera light, and tone down the specular highlighting
camlight('headlight');
material('dull');

% Fix the axes scaling, and set a nice view angle
%axis('image');
axis('equal');
