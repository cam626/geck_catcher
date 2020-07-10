w = vrworld('base_world.wrl');
open(w);

% save to XML encoding
save(w,'base_world.x3d');
